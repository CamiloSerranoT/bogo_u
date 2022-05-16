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
          color: Colors.black, // Color de la barra inferior del texto
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
        ), 
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.black, // Color del fraseo del texto
      ),
      prefixIcon: prefix != null? Icon(prefix, color:Colors.black):null, // Color del icono
      border: InputBorder.none,
    );
  }

  static InputDecoration authInputDecorationGeneral({
    required String hintText,
    required String labelText,
    IconData? prefix,
  }){
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          // Borde
          color: Colors.white, // Color de la barra inferior del texto
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ), 
        borderRadius: BorderRadius.circular(20),
      ),
      errorStyle: TextStyle(color: Colors.white),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ), 
        borderRadius: BorderRadius.circular(20),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ), 
        borderRadius: BorderRadius.circular(20),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white, // Color del fraseo del texto
      ),
      prefixIcon: prefix != null? Icon(prefix, color:Colors.white):null, // Color del icono
      border: InputBorder.none,
    );
  }
  
}