import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:bogo_u/models/models.dart';
import 'package:http/http.dart' as http;

class LugarService extends ChangeNotifier{

  final List<Lugar> lugares =[];
  final String _baseUrl = 'bogo-u-default-rtdb.firebaseio.com';
  bool isLoading = true; 
  late Lugar lugarSelect;

  LugarService(){
    this.loadLugares();
  }
  Future <List<Lugar>> loadLugares() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'lugares.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> lugaresMap = json.decode(respuesta.body);

    lugaresMap.forEach((key, value) {
      final lugarTemp = Lugar.fromJson(value);
      lugarTemp.id = key;
      this.lugares.add(lugarTemp);
    });

    isLoading = false;
    notifyListeners();
    return lugares;
  }

  Future <List<Lugar>> actualizar() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'lugares.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> lugaresMap = json.decode(respuesta.body);

    lugaresMap.forEach((key, value) {
      final lugarTemp = Lugar.fromJson(value);
      lugarTemp.id = key;
      this.lugares.add(lugarTemp);
    });

    isLoading = false;
    notifyListeners();
    return lugares;
  }
}