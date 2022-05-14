import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/services/services.dart';
import 'package:provider/provider.dart';

class menuPage extends StatelessWidget {
  const menuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServiceNuevo = Provider.of<AuthService>(context, listen: false); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Color.fromARGB(255, 53, 52, 56),
      ),
      body: Container(
        child: SingleChildScrollView(
          //Hace scroll si sus hijos sobre pasan el tamaño de la pantalla
          child: Column(
            children: [
              SizedBox(height: 20),
              CardContainerDark(
                child: Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(context, 'conciertos'),
                      child: Text('Conciertos',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(context, 'museos'),
                      child: Text('Museos',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(context, 'escenarios'),
                      child: Text('Escenarios',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(context, 'bailes'),
                      child: Text('Bailes',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(context, 'entradalibre'),
                      child: Text('Entrada libre',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                  ],
                )
              ),
              SizedBox(height: 20),
              CardContainerDark(
                child: Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(context, 'boletas'),
                      child: Text('Boletas',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                  ],
                )
              ),
              SizedBox(height: 20),
              CardContainerDark(
                child: Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () => Navigator.pushNamed(context, 'configuraciones'),
                      child: Text('Configuraciones',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                          MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      onPressed: () { 
                        authServiceNuevo.logout(); // Por validar
                        Navigator.popAndPushNamed(context, 'login');
                      },
                      child: Text('Cerrar Sesión',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
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