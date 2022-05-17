import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:bogo_u/models/models.dart';
import 'package:http/http.dart' as http;

class UsuarioService extends ChangeNotifier{

  final List<Usuario> usuarios =[];
  final String _baseUrl = 'bogo-u-default-rtdb.firebaseio.com';
  bool isLoading = true; 
  late Usuario usuariosSelect;

  UsuarioService(){
    this.loadUsuarios();
  }
  Future <List<Usuario>> loadUsuarios() async{
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'usuarios.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> usuariosMap = json.decode(respuesta.body);

    usuariosMap.forEach((key, value) {
      final usuarioTemp = Usuario.fromJson(value);
      usuarioTemp.id = key;
      this.usuarios.add(usuarioTemp);
    });

    isLoading = false;
    notifyListeners();
    return usuarios;
  }
}