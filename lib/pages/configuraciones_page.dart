import 'dart:io';

import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:provider/provider.dart';

class configuracionesPage extends StatelessWidget {
  const configuracionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); 
    final datos = Provider.of<LoginFormProvider>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    bool estado = false;
    print(datos.correo);
    print(datos.contrasena);
    print(usuarioService.usuarios[0].correo);
    print(usuarioService.usuarios[1].correo);
    print(usuarioService.usuarios[2].correo);
    print(usuarioService.usuarios[3].correo);
    print(usuarioService.usuarios[4].correo);
    //print(usuarioService.usuarios[4].correo);
    if(usuarioService.isLoading) return LoadingPage();

    for(int i = 0; i<usuarioService.usuarios.length;i++){
      if(usuarioService.usuarios[i].correo == datos.correo && estado == false){
        usuarioService.usuariosSelect = usuarioService.usuarios[i].copy();
        estado=true;
      }
    }
    
    //usuarioService.usuariosSelect = usuarioService.usuarios[0].copy(); // Quitar fuera de pruebas
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Color.fromARGB(255, 105, 16, 10),
                Color.fromARGB(255, 243, 115, 105)
              ],
            ),
          ),
        ),
        title: Text('Datos generales'),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              authService.logout();
              Navigator.pushReplacementNamed(context, 'checking');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: CardUsuario(),
      bottomNavigationBar: BarraInferior(indexInit: 2),
    );
  }
}
