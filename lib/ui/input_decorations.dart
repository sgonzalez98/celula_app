import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String labelText, IconData? prefixIcon}) {
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue[900]!)),
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey[300],
        labelStyle: TextStyle(color: Colors.grey[900]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.blue[900])
            : null);
  }
}
