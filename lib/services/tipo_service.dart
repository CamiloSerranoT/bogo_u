import 'dart:convert';

import 'package:bogo_u/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TipoService extends ChangeNotifier{

  List<Tipo> tipos =[];
  final String _baseUrl = 'bogo-u-default-rtdb.firebaseio.com';
  bool isLoading = true; 
  late Tipo tipoSelect;

  TipoService(){
    this.loadTipos();
  }
  Future <List<Tipo>> loadTipos() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'tipos.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> tiposMap = json.decode(respuesta.body);

    tiposMap.forEach((key, value) {
      final tipoTemp = Tipo.fromJson(value);
      tipoTemp.id = key;
      this.tipos.add(tipoTemp);
    });

    isLoading = false;
    notifyListeners();
    return tipos;
  }

  Future <List<Tipo>> actualizar() async{
    List<Tipo> tiposNew =[];
    this.tipos = tiposNew;
    final url = Uri.https(_baseUrl,'tipos.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> tiposMap = json.decode(respuesta.body);

    tiposMap.forEach((key, value) {
      final tipoTemp = Tipo.fromJson(value);
      tipoTemp.id = key;
      this.tipos.add(tipoTemp);
    });

    notifyListeners();
    return tipos;
  }
}