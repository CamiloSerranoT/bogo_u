import 'package:flutter/cupertino.dart';
import 'package:bogo_u/models/models.dart';

class UsuarioFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Usuario usuario;

  UsuarioFormProvider(this.usuario);

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;    
  }
  
  updateEstado(bool value){
    this.usuario.estado = value;
    notifyListeners();
  }
}