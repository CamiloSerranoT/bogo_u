import 'package:bogo_u/models/evento.dart';
import 'package:bogo_u/models/evento_prueba.dart';
import 'package:bogo_u/pages/evento_widget_page.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/dao/dao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

class MainPageNew extends StatefulWidget {
  
  MainPageNew({ Key? key }) : super(key: key);
  final eventoDAO = EventoDAO();

  @override
  MainPageNewState createState() => MainPageNewState();
}

class MainPageNewState extends State<MainPageNew> {

  ScrollController _scrollController = ScrollController();
  TextEditingController eventoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollHabiaAbajo());

    return Scaffold(
      appBar:AppBar(title:const Text('Ejemplo Chat')),
      body:Padding(
        padding:EdgeInsets.all(16.0),
        child: Column(
          children: [
            _getLista(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: eventoController,
                      onChanged: (text) => setState(() {}),
                      onSubmitted: (input) {
                        _envierEvento();
                      },
                      decoration: const InputDecoration(
                        hintText: 'Escriba'
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _envierEvento();
                  }, 
                  icon: Icon(_puedoEnviar() ? CupertinoIcons.arrow_right_circle_fill:
                  CupertinoIcons.arrow_right_circle),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'principal');
                  }, 
                  icon: Icon(CupertinoIcons.mail),
                ),
              ],
            ),
          ],
        ),
      )
    );
  } 

  void _envierEvento() {
    if(_puedoEnviar()) {
      final evento = Evento(
        anual: 'anual',
        apertura: 'apertura', 
        descripcion: 'descripcion', 
        dias: 'dias', 
        estado: true, 
        inicio: 'inicio', 
        lugar: 1, 
        mes: 'mes', 
        nombre: eventoController.text, 
        tipo: 1, 
        valor: 20000,
        id: '',
      );
      widget.eventoDAO.guardarEvento(evento);
      eventoController.clear();
      setState(() {});
    }
  }

  bool _puedoEnviar() => eventoController.text.length > 0;

  void _scrollHabiaAbajo(){
    if(_scrollController.hasClients){
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Widget _getLista() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.eventoDAO.getEvento(),
        itemBuilder:(context,snapshot,animation,index){
          final json=snapshot.value as Map<dynamic,dynamic>;
          final evento=EventoPrueba.fromJson(json);
          return EventoWidget(
            evento.anual,
            evento.apertura,
            evento.descripcion,
            evento.dias,
            evento.estado,
            evento.id,
            evento.imagen,
            evento.inicio,
            evento.lugar,
            evento.mes,
            evento.nombre,
            evento.tipo,
            evento.valor,
          );
        },
      )
    );
  }
}

