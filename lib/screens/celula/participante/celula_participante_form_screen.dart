import 'package:celula_app/models/celula_participante.dart';
import 'package:celula_app/services/celula_participante_service.dart';
import 'package:celula_app/services/notifications_service.dart';
import 'package:celula_app/ui/input_decorations.dart';
import 'package:flutter/material.dart';

class CelulaParticipanteFormScreen extends StatefulWidget {
  const CelulaParticipanteFormScreen({Key? key, required this.celulaParticipante}) : super(key: key);

  final CelulaParticipante celulaParticipante;

  @override
  State<CelulaParticipanteFormScreen> createState() => _CelulaParticipanteFormScreenState();
}

class _CelulaParticipanteFormScreenState extends State<CelulaParticipanteFormScreen> {
  final celulaParticipanteService = CelulaParticipanteService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    CelulaParticipante participante = widget.celulaParticipante;

    return Scaffold(
      appBar: AppBar(
        title: participante.id != null
            ? const Text('Actualización de participante')
            : const Text('Creación de participante'),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        initialValue: participante.nombre,
                        decoration: InputDecorations.authInputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icons.lock_outlined,
                        ),
                        onChanged: (value) => participante.nombre = value,
                        validator: (value) {
                          if (value != null && value.length >= 3) {
                            return null;
                          }
                          return 'El nombre debe ser mayor a 2 caracteres';
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        autocorrect: false,
                        initialValue: participante.telefono,
                        decoration: InputDecorations.authInputDecoration(
                          labelText: 'Telefono',
                          prefixIcon: Icons.numbers,
                        ),
                        onChanged: (value) => participante.telefono = value,
                        validator: (value) {
                          if (value != null && value.length >= 6) {
                            return null;
                          }
                          return 'El telefono debe de ser de mas de 5 caracteres';
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        autocorrect: false,
                        initialValue: participante.edad != null ? participante.edad.toString() : '',
                        keyboardType: TextInputType.number,
                        decoration: InputDecorations.authInputDecoration(
                          labelText: 'Edad',
                          prefixIcon: Icons.numbers,
                        ),
                        onChanged: (value) => participante.edad = value.isNotEmpty ? int.parse(value) : null,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          return 'La edad es requerida';
                        },
                      ),
                      const SizedBox(height: 15),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        color: Colors.blue[900],
                        onPressed: _isSaving
                            ? null
                            : () async {
                                if (!isValidForm()) return;

                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _isSaving = true;
                                });

                                await celulaParticipanteService.saveOrCreateProduct(participante);
                                NotificationsService.showSnackBar('Registro guardado');

                                setState(() {
                                  _isSaving = false;
                                });

                                Navigator.pop(context);
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                          child: Text(
                            _isSaving ? 'Espere...' : 'Guardar',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}
