// ignore: file_names

import 'package:flutter/material.dart';

 
class LoginFormProvider with ChangeNotifier{
 
  GlobalKey<FormState> formKey = GlobalKey<FormState>();  // es la variable que está pendiente de los estados de todos los key,
                                                          // en este del formulario por eso es un FormState.          
  String email ='';
  String password = '';
  String _nombres ='';
  String _apellidos = '';
  String _telefono = '';
 
  bool _isLoading =false;
 
  bool get isLoading => _isLoading;
   
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  set correo(String correo){
    email = correo;
    notifyListeners();
  }

  String get correo{
    return email;
  }

  set contrasena(String contrasena){
    password = contrasena;
    notifyListeners();
  }

  String get contrasena{
    return password;
  }

  set nombres(String nombres){
    _nombres = nombres;
    notifyListeners();
  }

  String get nombres{
    return _nombres;
  }

  set apellidos(String apellidos){
    _apellidos = apellidos;
    notifyListeners();
  }

  String get apellidos{
    return _apellidos;
  }

  set telefono(String telefono){
    _telefono = telefono;
    notifyListeners();
  }

  String get telefono{
    return _telefono;
  }

}
