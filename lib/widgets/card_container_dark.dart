
import 'package:flutter/material.dart';

class CardContainerDark extends StatelessWidget {
 
  const CardContainerDark({Key? key,required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

    BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.grey[400],
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.black,
        blurRadius: 30,            //Es la difuminación de la sombra 
        offset: Offset(5,5),       // Se desplaza la sombra 5 a la derecha y 5 abajo. 
      )
    ]
  );
}

