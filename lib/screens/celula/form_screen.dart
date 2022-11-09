import 'package:celula_app/models/celula.dart';
import 'package:celula_app/services/celula_service.dart';
import 'package:celula_app/services/notifications_service.dart';
import 'package:celula_app/ui/input_decorations.dart';
import 'package:flutter/material.dart';

class CelulaFormScreen extends StatefulWidget {
  const CelulaFormScreen({Key? key, required this.celula}) : super(key: key);

  final Celula celula;

  @override
  State<CelulaFormScreen> createState() => _CelulaFormScreenState();
}

class _CelulaFormScreenState extends State<CelulaFormScreen> {
  final celulaService = CelulaService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSaving = false;

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    Celula celula = widget.celula;

    return Scaffold(
      appBar: AppBar(
        title: celula.id != null ? const Text('Actualización de celula') : const Text('Creación de celula'),
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
                      DropdownButtonFormField<String>(
                        items: const [
                          DropdownMenuItem(value: 'Adolecentes', child: Text('Adolecentes')),
                          DropdownMenuItem(value: 'Ninos', child: Text('Niños')),
                          DropdownMenuItem(value: 'Jovenes', child: Text('Jovenes')),
                          DropdownMenuItem(value: 'Damas', child: Text('Damas')),
                          DropdownMenuItem(value: 'Hombres', child: Text('Hombres')),
                          DropdownMenuItem(value: 'Familia', child: Text('Familia')),
                        ],
                        onChanged: (value) => {celula.ministerio = value ?? ''},
                        value: celula.ministerio,
                        decoration: InputDecorations.authInputDecoration(labelText: 'Ministerio'),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        autocorrect: false,
                        initialValue: celula.lugar,
                        decoration: InputDecorations.authInputDecoration(
                          labelText: 'Lugar',
                          prefixIcon: Icons.lock_outlined,
                        ),
                        onChanged: (value) => celula.lugar = value,
                        validator: (value) {
                          if (value != null && value.length >= 6) {
                            return null;
                          }
                          return 'La contraseña debe tener mas de 5 caracteres';
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        items: const [
                          DropdownMenuItem(value: 'Lunes', child: Text('Lunes')),
                          DropdownMenuItem(value: 'Martes', child: Text('Martes')),
                          DropdownMenuItem(value: 'Miercoles', child: Text('Miercoles')),
                          DropdownMenuItem(value: 'Jueves', child: Text('Jueves')),
                          DropdownMenuItem(value: 'Viernes', child: Text('Viernes')),
                          DropdownMenuItem(value: 'Sabado', child: Text('Sabado')),
                          DropdownMenuItem(value: 'Domingo', child: Text('Domingo')),
                        ],
                        onChanged: (value) => {celula.dia = value ?? ''},
                        value: celula.dia,
                        decoration: InputDecorations.authInputDecoration(
                            labelText: 'Dia', prefixIcon: Icons.calendar_month_sharp),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                          onPressed: () {
                            final DateTime now = DateTime.now();
                            showTimePicker(context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
                                .then((TimeOfDay? value) {
                              if (value != null) {
                                celula.hora = value.format(context);
                                setState(() {});
                              }
                            });
                          },
                          child: Text('Hora ${celula.hora}')),
                      const SizedBox(height: 15),
                      TextFormField(
                        autocorrect: false,
                        initialValue: celula.descripcion,
                        decoration:
                            InputDecorations.authInputDecoration(labelText: 'Descripcion', prefixIcon: Icons.person),
                        onChanged: (value) => celula.descripcion = value,
                        validator: (value) {
                          if (value != null && value.length >= 6) {
                            return null;
                          }
                          return 'El usuario debe de ser de mas de 5 caracteres';
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

                                await celulaService.saveOrCreate(celula);
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
