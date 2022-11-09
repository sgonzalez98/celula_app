import 'package:celula_app/models/celula.dart';
import 'package:flutter/material.dart';

class CelulaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Celula celula;

  CelulaFormProvider(this.celula);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
