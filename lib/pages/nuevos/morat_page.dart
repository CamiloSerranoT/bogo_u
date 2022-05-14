import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/models/models.dart';
import 'package:provider/provider.dart';

class moratPage extends StatelessWidget {
  const moratPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morat'),
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
              SizedBox(height: 5,),
              CardContainerv2(
                child: Column(
                  children: [
                    ChangeNotifierProvider(
                      // este objeto se crea y va a estar alojado en el _loginForm() y a la vez puede redibujar los Widgets necesarios
                      create: (_) {},
                      child: _Evento(),
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

class _Evento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<LoginFormProvider>(context);
    return Form(
      key: datos.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: 10,),
          CardContainerv2(
            child: Image.asset(
              'assets/img/morat2.jpg',
              //height: 50,
              scale: 1.4,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Morat',
            style: TextStyle(
              fontSize: 20, color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            'Movistar Arena',
            style: TextStyle(
              fontSize: 14, color: Colors.black.withOpacity(0.4),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            'Dg. 61c #26-36, Bogotá, Cundinamarca',
            style: TextStyle(
              fontSize: 14, color: Colors.black.withOpacity(0.4),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            '   4:00 pm Puertas      |      8:00 pm Inicio   ',
            style: TextStyle(
              fontSize: 14, color: Colors.black.withOpacity(0.4),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 15),
          CardContainer(
            child: Column(
              children: [
                Text(
                  'Información General',
                  style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  '18, 19, 20 y 23 de marzo',
                  style: TextStyle(
                    fontSize: 18, color: Colors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 15),
                Text(
                  '¡De regreso a la ciudad que los vio crecer! Después de agotar diferentes escenarios en España, México y Estados Unidos, Morat vuelve a Colombia con su gira ¿A Dónde Vamos?',
                  style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Text(
                  'La banda Colombiana conformada por Juan Pablo Isaza, Juan Pablo Villamil, Simón Vargas y Martín Vargas, vuelve a la capital después de 2 años. Se estarán presentando en el Movistar Arena el próximo 18,19 y 20 de marzo de 2022.',
                  style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Text(
                  'Esta será la oportunidad para reencontrarse con sus fans que los siguen desde sus inicios con un show completamente nuevo.',
                  style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Row(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}