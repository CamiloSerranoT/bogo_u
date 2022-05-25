import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/providers/providers.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  _UsuarioBody({
    Key? key,
  }) : super(key: key);

  Usuario usuario = Usuario(
    apellidos: '',
    clave: '',
    correo: '',
    estado: true,
    nombres: '',
    telefono: 0,
  );
  final usuarioDAO = UsuarioDAO(); 

  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            _UsuarioForm(usuario: usuario)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //floatingActionButton: _AgregarButton(),
    );
  }
}

class _UsuarioForm extends StatelessWidget {
  _UsuarioForm({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final usuarioDAO = UsuarioDAO();
  late Usuario usuario;

  @override
  Widget build(BuildContext context) {
    final usuarioForm = Provider.of<UsuarioFormProvider>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    usuario = usuarioForm.usuario;

    for(int i=0;i<usuarioService.usuarios.length;i++){
      if(usuarioService.usuarios[i].correo == usuario.correo){
        usuario = usuarioService.usuarios[i];
      }
    }

    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 20, top: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'modificarimagenusuario');
                      },
                      icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                    )
                  ),
                  ImageUsuario(url: usuario.imagen),
                ],
              ),
              //ImageUsuario(url: usuario.imagen),
              SizedBox(height: 10,),
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
              SizedBox(height: 25,),
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
              SizedBox(height: 25,),   
              Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  alignment: Alignment.center, 
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.0),
                        offset: const Offset(0,0),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    '${usuario.correo}',
                    style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                  ),
                ),
              ),    
              SizedBox(height: 25,),
              TextFormField(
                initialValue: '${usuario.telefono}',
                onChanged: ( value ) => usuario.telefono = int.parse(value),
                keyboardType: TextInputType.number, // Deja solo teclado numerico 
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El telefono es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: 'Telefono',
                  labelText: 'Telefono',
                ),
              ),
              SizedBox(height: 25,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  disabledColor: Colors.white,
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Guardar ajustes',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    if(usuario.nombres.length < 1 || usuario.nombres == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca un nombre de usuario'));
                    }else if(usuario.apellidos.length < 1 || usuario.apellidos == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca un apellido de usuario'));
                    }else if(usuario.telefono < 999999){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nEl telefono debe tener minimo 7 digitos'));
                    }else{
                      _modificarUsuario();
                      usuarioService.actualizar();
                      Navigator.pushNamed(context, 'principal');
                    }
                  },
                ),
              ),
              SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }

  void _modificarUsuario() {
    usuarioDAO.modificarTodoUsuario(usuario.id!,usuario);
  }

  SnackBar _Error(fraseo){    
    final snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          fraseo,
          style: TextStyle(fontSize: 15,color: Colors.black,),
        ),
        action: SnackBarAction(
          label: 'Ocultar',
          textColor: Colors.red,
          onPressed: () {},
        ),
      );
    return snackBar;
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
