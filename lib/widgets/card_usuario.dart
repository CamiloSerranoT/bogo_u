import 'package:bogo_u/providers/providers.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/ui/input_decorations.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardUsuario extends StatelessWidget {
  
  const CardUsuario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    return ChangeNotifierProvider(
      create: ( _ ) => UsuarioFormProvider(usuarioService.usuariosSelect),
      child: _UsuarioBody(),
    );
  }
}

class _UsuarioBody extends StatelessWidget {
  const _UsuarioBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            _UsuarioForm()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _AgregarButton(),
    );
  }
}

class _UsuarioForm extends StatelessWidget {
  const _UsuarioForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioForm = Provider.of<UsuarioFormProvider>(context);
    final usuario = usuarioForm.usuario;
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              ImageUsuario(url: usuario.imagen),
              TextFormField(
                initialValue: usuario.nombres,
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.nombres = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'Los nombres son obligatorios';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: 'Nombres', 
                  labelText: 'Nombres',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: usuario.apellidos,
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.apellidos = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'Los apellidos son obligatorios';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: 'Apellidos', 
                  labelText: 'Apellidos',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: usuario.correo,
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.correo = value,
                validator: (value) {
                  //Return null cuando es aceptada la expresion escrita.
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '') ? null : 'No es un correo';
                },
                style: const TextStyle(fontSize: 20,color: Colors.white),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: 'Correo', 
                  labelText: 'Correo',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: '${usuario.telefono}',
                onChanged: ( value ) => usuario.telefono = int.parse(value),
                keyboardType: TextInputType.number, // Deja solo teclado numerico 
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El telefono es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 18,color: Colors.white,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: 'Telefono',
                  labelText: 'Telefono',
                ),
              ),
              SizedBox(height: 15,),
              SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible',style: TextStyle(color: Colors.white),),
                activeColor: Colors.white, 
                onChanged: usuarioForm.updateEstado,
              ),
              SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.all(Radius.circular(30)),
    gradient: LinearGradient(
      colors: [
      //  Colors.indigo,
      //  Colors.red
        Colors.black.withOpacity(0.85),
        Color.fromARGB(255, 105, 16, 10).withOpacity(0.9),
        Color.fromARGB(255, 243, 115, 105),
        Color.fromARGB(255, 105, 16, 10).withOpacity(0.9),
        Colors.black.withOpacity(0.85),
      ],
    ), 
    boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 10,
          spreadRadius: 5,
        ),
      ],
  );
}

class _AgregarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        Icons.save_outlined,
        size: 45,
        color: Colors.white,
      ),
      onPressed: (){

      },
    );
  }
}
