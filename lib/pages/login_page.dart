import 'package:flutter/material.dart';
import 'package:bogo_u/models/login_Form.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/services/services.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bogo_U'),
        backgroundColor: Color.fromARGB(255, 53, 52, 56),
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
                      'Bienvenido',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 30),
                    ChangeNotifierProvider(
                      // este objeto se crea y va a estar alojado en el _loginForm() y a la vez puede redibujar los Widgets necesarios
                      create: (_) {},
                      child: _LoginForm(),
                    ),
                  ],
                )
              ),
              SizedBox(height: 35,),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                onPressed: () => Navigator.popAndPushNamed(context, 'register'),
                child: Text('Crear una nueva cuenta',
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
                labelText: 'Correo electronico',
                prefix: Icons.alternate_email,
                hintText: 'correo@gmail.com'),
            onChanged: (value) => loginForm.correo = value,
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
            onChanged: (value) => loginForm.contrasena = value,
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
                loginForm.isLoading ? 'Espere' : 'Ingresar',
                style: TextStyle(color: Colors.white,),              
              ),
            ),
            onPressed: loginForm.isLoading
              ? null
              : () async {
                  FocusScope.of(context).unfocus(); //inhabilita el teclado
                  final authService = Provider.of<AuthService>(context,listen: false);
                  if (!loginForm.isValidForm()) return; // si no es valido retorna
                  loginForm.isLoading = true;
                  final String? errorMessage = await  authService.login(
                    loginForm.email, loginForm.password
                  );
                  
                  if (errorMessage == null) {
                    Navigator.pushNamed(context, 'principal');
                  } else {
                    print(errorMessage);
                  }
                  loginForm.isLoading = false;
                }),
        ],
      ),
    );
  }
}