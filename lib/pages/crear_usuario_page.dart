import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';

class CrearUsuarioPage extends StatefulWidget {
  
  CrearUsuarioPage({ Key? key }) : super(key: key);
  final eventoDAO = LugarDAO();

  @override
  CrearUsuarioFormPage createState() => CrearUsuarioFormPage();
}

class CrearUsuarioFormPage extends State<CrearUsuarioPage> {

  Usuario usuario = Usuario(
    apellidos: '',
    clave: '',
    correo: '',
    estado: true,
    nombres: '',
    telefono: 0,
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
        title: Text('Crear usuario'),
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
            _UsuarioForm(usuario: usuario,),
          ],
        ),
      ),
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
    
    final usuarioService = Provider.of<UsuarioService>(context);
    final datos = Provider.of<LoginFormProvider>(context);

    usuario.correo = datos.correo;
    usuario.clave = datos.contrasena;
    
    
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 30,),
              TextFormField(
                autocorrect: false,
                initialValue: '${usuario.nombres}',
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.nombres = value,
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
                  labelText: 'Nombres',
                ),
              ),
              SizedBox(height: 25,),
              TextFormField(
                autocorrect: false,
                initialValue: '${usuario.apellidos}',
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.apellidos = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El apellido es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'Apellidos',
                ),
              ),
              SizedBox(height: 25,),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                onChanged: ( value ) => usuario.telefono = int.parse(value),
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El telefono es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'Telefono',
                ),
              ),
              SizedBox(height: 25,),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: ( value ) => usuario.imagen = value,
                style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'URL imagen(Opcional)',
                ),
              ),
              SizedBox(height: 30,),
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
                      'Validar',
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
                      _enviarUsuario();
                      usuarioService.actualizar();
                      Navigator.pushNamed(context, 'principal');
                    }
                  },
                ),
              ),
              SizedBox(height: 25,),
            ],
          )
        ),
      ),
    );
  }

  void _enviarUsuario() {
    usuarioDAO.guardarUsuario(usuario);
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
