import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:bogo_u/models/models.dart';
import 'package:http/http.dart' as http;

class EventoService extends ChangeNotifier{

  List<Evento> eventos =[];
  final String _baseUrl = 'bogo-u-default-rtdb.firebaseio.com';
  bool isLoading = true; 
  late Evento eventoSelect;

  EventoService(){
    this.loadEventos();
  }
  
  Future <List<Evento>> loadEventos() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'eventos.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> eventosMap = json.decode(respuesta.body);

    eventosMap.forEach((key, value) {
      final eventoTemp = Evento.fromJson(value);
      eventoTemp.id = key;
      this.eventos.add(eventoTemp);
    });

    isLoading = false;
    notifyListeners();
    return eventos;
  }

  Future <List<Evento>> actualizar() async{
    List<Evento> eventosNew =[];
    this.eventos = eventosNew;
    final url = Uri.https(_baseUrl,'eventos.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> eventosMap = json.decode(respuesta.body);

    eventosMap.forEach((key, value) {
      final eventoTemp = Evento.fromJson(value);
      eventoTemp.id = key;
      this.eventos.add(eventoTemp);
    });
    notifyListeners();
    return eventos;
  }
}