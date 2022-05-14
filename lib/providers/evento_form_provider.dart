import 'package:flutter/cupertino.dart';
import 'package:bogo_u/models/models.dart';

class EventoFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Evento evento;

  EventoFormProvider(this.evento);

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;    
  }
  
  updateEstado(bool value){
    this.evento.estado = value;
    notifyListeners();
  }
}