import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class boletasPage extends StatelessWidget {
  const boletasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventoService = Provider.of<EventoService>(context);
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
        title: Text('Boletas'),
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
      body: Container(),
      bottomNavigationBar: BarraInferior(indexInit: 1),
    );
  }
}
