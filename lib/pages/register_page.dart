import 'package:bogo_u/models/login_Form.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
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
              ChangeNotifierProvider(
                create: ( _ ) => LoginFormProvider(),
                child: CardContainerGeneral(child: RegisterFormatPage(),),
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
}
