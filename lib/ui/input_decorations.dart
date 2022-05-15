import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefix,
  }){
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          // Barra inferior de texto
          color: Colors.white, // Color de la barra inferior del texto
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white, //
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        // 
        color: Colors.white, // Color del fraseo del texto
      ),
      prefixIcon: prefix != null? Icon(prefix, color:Colors.white):null, // Color del icono
    );
  }

  
}