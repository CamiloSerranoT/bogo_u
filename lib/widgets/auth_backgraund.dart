import 'package:flutter/material.dart';
 
class AuthBackground extends StatelessWidget {
  
  final Widget child;  // creamos el constructor con ctrl + punto encima del child
 
  const AuthBackground({Key? key,required this.child}) : super(key: key);  
 
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: double.infinity,
      height: double.infinity,
      child: Stack(   // crea widgets uno encima del otro.
        children:  [
           _PurpeBox(),
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}
 
class _PurpeBox extends StatelessWidget {
  
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
 
    return Container(
      width: double.infinity,
      height: size.height*0.4,
      decoration: _purpeBackground(),  //Escribimo BoxDecoration y le damos ctrl+punto y extract Method y escribimos _purpeBackground
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: 70, left: 80,),
          Positioned(child: _Bubble(), top: -40, left: -30,),
          Positioned(child: _Bubble(), top: -50, right: -20,),
          Positioned(child: _Bubble(), bottom: -50, left: 10,),
          Positioned(child: _Bubble(), bottom: 10, right: 20,),
        ],
      ),
    );
  }
 
  BoxDecoration _purpeBackground() {
    return BoxDecoration(   
      gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1),
      ]
      ),
    );
  }
}
 
class _Bubble extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:Color.fromRGBO(255, 255, 255, 0.5),
      ),
    );
  }

  
}


class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(Icons.person_pin, color: Colors.white, size: 100,),
      )
    );
  }
}

