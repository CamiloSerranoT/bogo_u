import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/widgets/widgets.dart';

class escenariosPage extends StatelessWidget {
  const escenariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Escenarios'),
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
                    //Movistar Arena
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 198, vertical: 15),
                        child: Text(
                          "Movistar Arena",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'movistar_arena');
                      },
                    ),
                    //Estadio El Campin
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
                          "Estadio El Campin",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'campin');
                      },
                    ),
                    //Aire libre
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 218, vertical: 15),
                        child: Text(
                          "Aire libre",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'aire_libre');
                      },
                    ),
                    //Teatros
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Color.fromARGB(255, 53, 52, 56),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 221.5, vertical: 15),
                        child: Text(
                          "Teatros",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'teatros');
                      },
                    ),
                    //BiblioRed
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 216.1, vertical: 15),
                        child: Text(
                          "BiblioRed",
                          style: TextStyle(
                            fontSize: 14, color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'bibliored');
                      },
                    ),
                    SizedBox(height: 20,),
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
