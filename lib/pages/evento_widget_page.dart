import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventoWidget extends StatelessWidget {

  final String anual;
  final String apertura;
  final String descripcion;
  final String dias;
  final bool estado;
  final String inicio;
  final int lugar;
  final String mes;
  final String nombre;
  final int tipo;
  final int valor;
  final String? imagen;
  final String? id;

  EventoWidget(
    this.anual,
    this.apertura,
    this.descripcion,
    this.dias,
    this.estado,
    this.id,
    this.imagen,
    this.inicio,
    this.lugar,
    this.mes,
    this.nombre,
    this.tipo,
    this.valor,
    
    
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left:1,top:5,right:1,bottom:2),
      child:Column(
        children:[
          Container(
            decoration:BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[350]!,
                  blurRadius: 2.0,
                  offset: Offset(0,1.0),
                ),
              ],
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white
            ),
            child: MaterialButton(
              disabledTextColor: Colors.black87,
              padding: EdgeInsets.only(left: 18),
              onPressed: null,
              child: Wrap(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        Text(nombre),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                dias + ' de ' + mes + ' del ' + anual,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ]
      ),  
    );
  }
}
