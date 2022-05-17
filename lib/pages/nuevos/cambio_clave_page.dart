import 'package:bogo_u/models/models.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';

class cambioClavePage extends StatelessWidget {
  const cambioClavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { 
                 Navigator.pushNamed(context, 'menu');
              },
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 53, 52, 56),
        actions: [
          
        ],
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
                    SizedBox(height: 10,),
                    Text(
                      'Cambio Contraseña',
                      style: Theme.of(context).textTheme.headline4,
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
    );
  }
}

class _Datos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<LoginFormProvider>(context);
    String claveNueva1 = '';
    String claveNueva2 = '';
    String claveAnt = '';
    return Form(
      //key: datos.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña antigua',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: claveAnt,
            onChanged: (value) => claveAnt = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'Debe tener al menos 6 caracteres';
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña nueva',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: claveNueva1,
            onChanged: (value) => claveNueva1 = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'Debe tener al menos 6 caracteres';
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Repetir contraseña nueva',
                //prefix: Icons.alternate_email,
                hintText: ''),
            initialValue: claveNueva2,
            onChanged: (value) => claveNueva2 = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'Debe tener al menos 6 caracteres';
            },
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
              padding: EdgeInsets.symmetric(horizontal: 180, vertical: 15),
              child: Text(
                datos.isLoading ? 'Espere' : 'Modificar',
                style: TextStyle(
                  fontSize: 14, color: Colors.white,
                ),
              ),
            ),
            onPressed: datos.isLoading
              ? null
              : () async {
                FocusScope.of(context).unfocus();
                //final authService = Provider.of<AuthService>(context,listen: false);
                datos.isLoading = true; 
                if(claveNueva1.isNotEmpty && claveNueva2.isNotEmpty && claveAnt.isNotEmpty){
                  if(claveNueva1.length >= 6 && claveNueva2.length >= 6 && claveAnt.length >= 6){
                    if(identical(claveNueva1, claveNueva2)){
                      if(identical(datos.contrasena, claveAnt)){
                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pushNamed(context, 'cambioclaveant');
                      }else{
                        final snackBar = SnackBar(
                          content: const Text('ERROR: La clave antigua no corresponde.\nPor favor, vuelva a escribirla.'),
                          action: SnackBarAction(
                            label: 'Ocultar',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushNamed(context, 'cambioclave');
                      }
                    }else{
                      final snackBar = SnackBar(
                        content: const Text('ERROR: Las claves nuevas no son iguales.\nPor favor, vuelva a escribirlas.'),
                        action: SnackBarAction(
                          label: 'Ocultar',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushNamed(context, 'cambioclave');
                    }
                  }else{
                    final snackBar = SnackBar(
                      content: const Text('Se recuerda que las contraseñas deben tener más de 6 caracteres.\nPor favor, rectifique los campos.'),
                      action: SnackBarAction(
                        label: 'Ocultar',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pushNamed(context, 'cambioclave');
                  }
                }else{
                  final snackBar = SnackBar(
                    content: const Text('ERROR: Algún campo de texto esta sin llenar.\nPor favor, rectifique los campos.'),
                    action: SnackBarAction(
                      label: 'Ocultar',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushNamed(context, 'cambioclave');
                }
                datos.isLoading = false;
            },
          ),
        ],
      ),
    );
  }
}
