import 'package:celula_app/models/celula_participante.dart';
import 'package:celula_app/screens/celula/participante/celula_participante_form_screen.dart';
import 'package:celula_app/screens/loading_screen.dart';
import 'package:celula_app/services/celula_participante_service.dart';
import 'package:flutter/material.dart';

class CelulaParticipanteScreen extends StatefulWidget {
  const CelulaParticipanteScreen({Key? key, required this.celulaId}) : super(key: key);

  final String celulaId;

  @override
  State<CelulaParticipanteScreen> createState() => _CelulaParticipanteScreenState();
}

class _CelulaParticipanteScreenState extends State<CelulaParticipanteScreen> {
  final celulaParticipanteService = CelulaParticipanteService();
  List<CelulaParticipante> _participantes = [];
  bool _isLoading = true;

  void loadParticipantes() async {
    _participantes = await celulaParticipanteService.loadParticipantes(widget.celulaId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadParticipantes();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes de la celula'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CelulaParticipanteFormScreen(
                                      celulaParticipante: CelulaParticipante(
                                        nombre: '',
                                        celulaId: widget.celulaId,
                                        telefono: '',
                                      ),
                                    )));
                        loadParticipantes();
                      },
                      color: Colors.green,
                      child: const Text('Agregar nuevo participante'),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _participantes.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        child: Column(children: [
                          Text('Nombre: ${_participantes[index].nombre}'),
                          Text('Edad: ${_participantes[index].edad}'),
                          Text('Telefono: ${_participantes[index].telefono}'),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CelulaParticipanteFormScreen(
                                                  celulaParticipante: _participantes[index].copy(),
                                                )));
                                    loadParticipantes();
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Eliminar'),
                                        content: const Text('¿Esta seguro de eliminar este integrante?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(context, 'Cancelar'),
                                              child: const Text('Cancelar')),
                                          TextButton(
                                              onPressed: () async {
                                                await celulaParticipanteService.delete(_participantes[index].id!);
                                                Navigator.pop(context, 'Aceptar');
                                                loadParticipantes();
                                              },
                                              child: const Text('Aceptar'))
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          )
                        ]),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
