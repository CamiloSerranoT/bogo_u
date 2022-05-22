import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/pages/pages.dart';

class principalPage extends StatelessWidget {
  const principalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventoService = Provider.of<EventoService>(context);
    final authService = Provider.of<AuthService>(context, listen: false); 
    if(eventoService.isLoading) return LoadingPage();
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
        title: Text('Eventos'),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              authService.logout();
              Navigator.pushNamed(context, 'checking');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: eventoService.eventos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: CardEvento(
            evento: eventoService.eventos[index],
          ),
          onTap: () {
            eventoService.eventoSelect = eventoService.eventos[index].copy();
            Navigator.pushNamed(context, 'evento');
          },
        ), 
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _Agregar(),
      bottomNavigationBar: BarraInferior(indexInit: 0),
    );
  }
}

class _Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        Icons.playlist_add_rounded,
        size: 45,
        color: Colors.white,
      ),
      onPressed: (){

      },
    );
  }
}
