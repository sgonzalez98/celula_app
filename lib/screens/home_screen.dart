import 'package:celula_app/screens/celulas_screen.dart';
import 'package:celula_app/screens/desarrollos_screen.dart';
import 'package:celula_app/screens/informes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionProvider(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
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
        BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined), label: 'Celulas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room), label: 'Desarrollos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined), label: 'Informes'),
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
        CelulasScreen(),
        DesarrollosScreen(),
        InformesScreen()
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
    _pageController.animateToPage(_paginaActual,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
