import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        title: Text('Bogo_U'),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          //Hace scroll si sus hijos sobre pasan el tamaño de la pantalla
          child: Column(
            children: [
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 5),
                  width: double.infinity,
                  //height: 400,
                  decoration: _cardBorders(),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: [
                        ChangeNotifierProvider(
                          create: (_) {},
                          child: _RegisterFormatPage(),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35,),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                onPressed: () => Navigator.popAndPushNamed(context, 'checking'),
                child: Text('Ya tienes cuenta?',
                    style: TextStyle(fontSize: 17, color: Colors.black87)),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
        topRight: Radius.circular(40),
        bottomLeft: Radius.circular(40)
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.50),
          offset: const Offset(-10,10),
          blurRadius: 2,
        ),
      ],
    );
  }
}

class _RegisterFormatPage extends StatelessWidget {
  
  const _RegisterFormatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
 
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 400,
          decoration: _buildBoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Crear una cuenta',
                      style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),
                ),
                _ContainerTextCorreo(loginForm: loginForm,),
                SizedBox(height: 20),
                _ContainerTextClave(loginForm: loginForm,),
                SizedBox(height: 20),
                _ContainerButton(loginForm: loginForm),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40), 
      bottomRight: Radius.circular(40),
      topRight: Radius.circular(40), 
      bottomLeft: Radius.circular(40)
    ),
    gradient: LinearGradient(
      colors: [
      //  Colors.indigo,
      //  Colors.red
        Colors.black,
        Color.fromARGB(255, 105, 16, 10),
        Color.fromARGB(255, 243, 115, 105),
      ],
    ), 
  );
}
class _ContainerTextCorreo extends StatelessWidget {
  _ContainerTextCorreo({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 20,color: Colors.white,),
        decoration: InputDecorations.authInputDecorationGeneral(
            labelText: 'Correo electronico',
            prefix: Icons.alternate_email,
            hintText: 'correo@gmail.com',
        ),
        initialValue: '',
        onChanged: (value) => loginForm.correo = value,
        validator: (value) {
          //Return null cuando es aceptada la expresion escrita.
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          return regExp.hasMatch(value ?? '') ? null : 'No es un correo';
        },
    );
  }
}
class _ContainerTextClave extends StatelessWidget {
  _ContainerTextClave({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 20,color: Colors.white,),
        decoration: InputDecorations.authInputDecorationGeneral(
            labelText: 'Contraseña',
            prefix: Icons.lock_outline,
            hintText: '*****',
        ),
        initialValue: '',
        onChanged: (value) => loginForm.contrasena = value,
        validator: (value) {
          if (value != null && value.length >= 6) return null;
          return 'La contraseña debe contener mínimo 6 caracteres';
        },
    );
  }
}

class _ContainerButton extends StatelessWidget {
  const _ContainerButton({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 5),
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
            loginForm.isLoading ? 'Espere' : 'Crear',
            style: TextStyle(fontSize: 20,color: Colors.black,),              
          ),
        ),
        onPressed: loginForm.isLoading
          ? null
          : () async {
            FocusScope.of(context).unfocus(); //inhabilita el teclado
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              if (!loginForm.isValidForm())
                return; // si no es valido retorna
              loginForm.isLoading = true;
              //await Future.delayed(Duration(seconds: 2));
              final String? errorMessage = await authService.createUser(
                  loginForm.email, loginForm.password);
              if (errorMessage == null) {
                Navigator.pushReplacementNamed(context, 'principal');
              } else {
                print(errorMessage);
                loginForm.isLoading = false;
              }
          }
      ),
    );
  }
}

