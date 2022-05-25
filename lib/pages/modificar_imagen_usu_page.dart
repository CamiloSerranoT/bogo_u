import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';

class ModificarImagenUsuarioPage extends StatefulWidget {
  
  ModificarImagenUsuarioPage({ Key? key }) : super(key: key);
  final eventoDAO = LugarDAO();

  @override
  ModificarImagenUsuarioFormPage createState() => ModificarImagenUsuarioFormPage();
}

class ModificarImagenUsuarioFormPage extends State<ModificarImagenUsuarioPage> {

  Usuario usuario = Usuario(
    apellidos: '',
    clave: '',
    correo: '',
    estado: true,
    nombres: '',
    telefono: 0,
    imagen: null,
  );

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); 
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
        title: Text(
          'Modificar imagen',
          style: const TextStyle(fontSize: 25,color: Colors.white,),
        ),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              authService.logout();
              Navigator.pushNamed(context, 'checking');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            _LugarForm(usuario: usuario,),
          ],
        ),
      ),
    );
  }
}

class _LugarForm extends StatelessWidget {
  _LugarForm({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final usuarioDAO = UsuarioDAO(); 
  late Usuario usuario;
  
  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    if(usuarioService.isLoading) return LoadingPage();
    
    usuario = usuarioService.usuariosSelect;

    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.imagen = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El nombre es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'Enlace del usuario',
                ),
              ),
              SizedBox(height: 40,),
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
                      'Eliminar imagen actual',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    if(usuario.imagen == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('OBSERVACIÓN\nNo tenia imagen, por lo cual no se puede llevar a cabo esta acción.'));
                      Navigator.pushNamed(context, 'configuraciones');
                    }else{
                      usuario.imagen = null;
                      _modificarImagenusuario(usuario);
                      usuarioService.actualizar();
                      Navigator.pushNamed(context, 'configuraciones');
                    }
                  },
                ),
              ),
              SizedBox(height: 20,),
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
                      'Modificar',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    _modificarImagenusuario(usuario);
                    usuarioService.actualizar();
                    Navigator.pushNamed(context, 'configuraciones');
                  },
                ),
              ),
              SizedBox(height: 40,),
            ],
          )
        ),
      ),
    );
  }

  void _modificarImagenusuario(Usuario usuario) {
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
    borderRadius: BorderRadius.all(Radius.circular(20)),
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
