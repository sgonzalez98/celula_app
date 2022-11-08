import 'package:celula_app/models/celula.dart';
import 'package:celula_app/screens/celula/form_screen.dart';
import 'package:celula_app/screens/celula/participante/celula_participante_screen.dart';
import 'package:celula_app/screens/loading_screen.dart';
import 'package:celula_app/services/celula_service.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final celulaService = CelulaService();
  List<Celula> _celulas = [];
  bool _isLoading = true;

  void loadCelulas() async {
    _celulas = await celulaService.loadCelulas();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCelulas();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LoadingScreen();

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CelulaFormScreen(
                          celula: Celula(
                        usuarioId: '1',
                        lugar: 'Guarne',
                        hora: '',
                      ))),
            );
          },
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Agregar Nueva Celula'),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _celulas.length,
          itemBuilder: (BuildContext context, int index) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue[800]),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ministerio: ${_celulas[index].ministerio}', style: const TextStyle(color: Colors.white)),
                    Text('Lider: ${_celulas[index].usuarioId}', style: const TextStyle(color: Colors.white)),
                    Text('Lugar: ${_celulas[index].lugar}', style: const TextStyle(color: Colors.white)),
                    Text('Dia: ${_celulas[index].dia}', style: const TextStyle(color: Colors.white)),
                    Text('Hora: ${_celulas[index].hora}', style: const TextStyle(color: Colors.white)),
                    Text('Descripcion: ${_celulas[index].descripcion}', style: const TextStyle(color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => CelulaParticipanteScreen(celulaId: _celulas[index].id ?? ''))),
                            );
                          },
                          icon: const Icon(Icons.people),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => CelulaFormScreen(celula: _celulas[index].copy()))),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
