import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/ui/uis.dart';

class RegisterFormatPage extends StatelessWidget {
  
  const RegisterFormatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final loginFormAuxiliar = Provider.of<LoginFormAuxiliarProvider>(context);
    loginForm.formKey = loginFormAuxiliar.formKey;
    //print(object)
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
        obscureText: true,
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
            final authService = Provider.of<AuthService>(context, listen: false);
            if (!loginForm.isValidForm())
              return; // si no es valido retorna
            loginForm.isLoading = true;
            //await Future.delayed(Duration(seconds: 2));
            final String? errorMessage = await authService.createUser(
              loginForm.email, loginForm.password
            );
            if (errorMessage == null) {
              Navigator.pushReplacementNamed(context, 'crearusuario');
            } else {
              if(errorMessage == 'EMAIL_EXISTS'){
                ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nEl correo ya se encuentra registrado, por favor utilice uno diferente.'));
              }
              print(errorMessage);
            }
            loginForm.isLoading = false;
          }
      ),
    );
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
}
