import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:bogo_u/widgets/widgets.dart';

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
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      'Crear una cuenta',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 30),
                    ChangeNotifierProvider(
                      // este objeto se crea y va a estar alojado en el _loginForm() y a la vez puede redibujar los Widgets necesarios
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    )
                  ],
                )
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                onPressed: () => Navigator.popAndPushNamed(context, 'login'),
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
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Correo electrónico',
                prefix: Icons.alternate_email,
                hintText: 'correo@gmail.com'),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              //Return null cuando es aceptada la expresion escrita.
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'No es un correo';
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                prefix: Icons.lock_outline,
                hintText: '*****'),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'La contraseña debe contener mínimo 6 caracteres';
            },
          ),

          SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2)
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Color.fromARGB(255, 53, 52, 56),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 182, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Crear',
                  style: TextStyle(color: Colors.white),
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
                    }),
          //SizedBox(height: 30,),
        ],
      ),
    );
  }
}
