import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';

class configuracionesPage extends StatelessWidget {
  const configuracionesPage({Key? key}) : super(key: key);

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
        title: Text('Datos generales'),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          //Hace scroll si sus hijos sobre pasan el tamaño de la pantalla
          child: Column(
            children: [
              SizedBox(height: 10,),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Text(
                      'Datos Generales',
                      style: TextStyle(
                        fontSize: 20, color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      //style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 10,),
                    Image.asset(
                      'assets/img/profile.png',
                      //height: 50,
                      scale: 6,
                    ),
                    ChangeNotifierProvider(
                      create: (_) {},
                      child: _Datos(),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BarraInferior(indexInit: 2),
    );
  }
}

class _Datos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<LoginFormProvider>(context);
    return Form(
      //key: datos.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Nombres',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: ''/*+datos.nombres*/,
            onChanged: (value) => /*datos.nombres = value*/null,
            validator: (value) {
              if (value != null && value.length >= 1) return null;
              return 'Debe escribir algun caracter';
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Apellidos',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: ''/*+datos.apellidos*/,
            onChanged: (value) => /*datos.apellidos = value*/null,
            validator: (value) {
              if (value != null && value.length >= 1) return null;
              return 'Debe escribir algun caracter';
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Correo',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: ''+datos.correo,
            onChanged: (value) => datos.correo = value,
            validator: (value) {
              if (value != null && value.length >= 1) return null;
              return 'Debe escribir algun caracter';
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Telefono',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: ''/*+datos.telefono*/,
            onChanged: (value) => /*datos.telefono = value*/null,
            validator: (value) {
              if (value != null && value.length >= 1) return null;
              return 'Debe escribir algun caracter';
            },
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              
              Text(
                'Contraseña\t\t',
                style: TextStyle(
                  fontSize: 25, color: Colors.black,
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)
                ),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color.fromARGB(255, 53, 52, 56),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Text(
                    "Cambiar contraseña",
                    style: TextStyle(
                      fontSize: 14, color: Colors.white,
                    ),
                  ),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'cambioclave');
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2)
            ),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Color.fromARGB(255, 53, 52, 56),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 160, vertical: 15),
              child: Text(
                "Actualizar",
                style: TextStyle(
                  fontSize: 14, color: Colors.white,
                ),
              ),
            ),
            onPressed: (){
              Navigator.pushNamed(context, 'configuracionesact');
            },
          ),
        ],
      ),
    );
  }
}
