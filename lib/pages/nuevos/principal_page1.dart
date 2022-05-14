import 'package:bogo_u/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/services/services.dart';
import 'package:provider/provider.dart';

class principalPage1 extends StatelessWidget {
  const principalPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
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
                    SizedBox(height: 20,),
                    Text(
                      'Menú',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 30),
                    //Conciertos
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 180, vertical: 15),
                        child: Text(
                          "Conciertos",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'conciertos');
                      },
                    ),
                    //Museos
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Color.fromARGB(255, 53, 52, 56),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 189, vertical: 15),
                        child: Text(
                          "Museos",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'museos');
                      },
                    ),
                    //Escenarios
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 179.5, vertical: 15),
                        child: Text(
                          "Escenarios",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'escenarios');
                      },
                    ),
                    //Bailes
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Color.fromARGB(255, 53, 52, 56),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 195, vertical: 15),
                        child: Text(
                          "Bailes",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'bailes');
                      },
                    ),
                    //Entrada libre
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 175, vertical: 15),
                        child: Text(
                          "Entrada libre",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'entradalibre');
                      },
                    ),
                    SizedBox(height: 30,),
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
