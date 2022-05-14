import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';

class cambioClaveActPage extends StatelessWidget {
  const cambioClaveActPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Contraseña actualizada',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 30,),
                    Text(
                      'Se ha modificado satisfactoriamente la información',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 30,),
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
                          "Volver",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'configuraciones');
                      },
                    ),
                    SizedBox(height: 10,),
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
