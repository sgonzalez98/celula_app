import 'package:celula_app/screens/celula/list_screen.dart';
import 'package:celula_app/screens/desarrollos_screen.dart';
import 'package:celula_app/screens/informes_screen.dart';
import 'package:celula_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionProvider(),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logoCefeg.png', width: 50, height: 50),
                  const Text('Celulas CFE', style: TextStyle(color: Colors.white, fontSize: 26)),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Cerrar Sesión'),
                                content: const Text('¿Esta seguro de cerrar sesión?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final authService = AuthService();
                                      await authService.logout();
                                      Navigator.restorablePopAndPushNamed(context, 'login');
                                    },
                                    child: const Text('Aceptar'),
                                  )
                                ],
                              ));
                    },
                    color: Colors.red[500],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: const Text('Salir'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const _Paginas(),
        bottomNavigationBar: const _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionProvider = Provider.of<_NavegacionProvider>(context);
    return BottomNavigationBar(
      currentIndex: navegacionProvider.paginaActual,
      onTap: (i) => navegacionProvider.paginaActual = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Desarrollos'),
        BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Celulas'),
        BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined), label: 'Informes'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionProvider = Provider.of<_NavegacionProvider>(context);

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: navegacionProvider.pageController,
      children: const <Widget>[
        DesarrollosScreen(),
        ListScreen(),
        InformesScreen(),
      ],
    );
  }
}

class _NavegacionProvider with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(_paginaActual, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
