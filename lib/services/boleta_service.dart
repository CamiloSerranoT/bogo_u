import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:bogo_u/models/models.dart';
import 'package:http/http.dart' as http;

class BoletaService extends ChangeNotifier{

  final List<Boleta> boletas =[];
  final String _baseUrl = 'bogo-u-default-rtdb.firebaseio.com';
  bool isLoading = true; 
  late Boleta boletasSelect;

  BoletaService(){
    this.loadBoleta();
  }
  Future <List<Boleta>> loadBoleta() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'boletas.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> boletaMap = json.decode(respuesta.body);

    boletaMap.forEach((key, value) {
      final boletaTemp = Boleta.fromJson(value);
      boletaTemp.id = key;
      this.boletas.add(boletaTemp);
    });

    isLoading = false;
    notifyListeners();
    return boletas;
  }
}