import 'package:flutter/material.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/models/models.dart';
import 'package:provider/provider.dart';

class movistarArenaPage extends StatelessWidget {
  const movistarArenaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movistar Arena'),
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
              SizedBox(height: 10,),
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
            'Marzo 2022',
            style: TextStyle(
              fontSize: 14, color: Colors.black.withOpacity(0.4),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                onPressed: () => Navigator.popAndPushNamed(context, 'movistar_arena'),
                child: Text('COMPRA',
                    style: TextStyle(fontSize: 17, color: Colors.black87)),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                onPressed: () => Navigator.popAndPushNamed(context, 'morat'),
                child: Text('DETALLES',
                    style: TextStyle(fontSize: 17, color: Colors.black87)),
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}