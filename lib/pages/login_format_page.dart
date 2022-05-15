import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormatPage extends StatelessWidget {

  const LoginFormatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 200,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienvenido',
              style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
              
            ),
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
            Text('Lugar: ',
              style: TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            Text('Lugar: ',
              style: TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            Text('Lugar: ',
              style: TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            Text('Fecha: ',
              style: TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(25)),
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
