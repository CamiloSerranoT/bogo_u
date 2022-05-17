import 'package:flutter/material.dart';

class BarraInferior extends StatelessWidget {
  
  final int indexInit;

  const BarraInferior({
    Key? key,
    required this.indexInit,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: this.indexInit,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dynamic_feed_outlined),
          label: 'Eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list), 
          label: 'Boletas'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings), 
          label: 'Configuración'
        ),
      ],
      onTap: (index){
        if(index != indexInit){
          if(index == 0){
            Navigator.pushNamed(context, 'principal');
          }else if(index == 1){
            Navigator.pushNamed(context, 'boletas');
          }else if(index == 2){
            Navigator.pushNamed(context, 'configuraciones');
          }
        }
      },
    );
  }
}