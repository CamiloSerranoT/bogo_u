import 'package:flutter/material.dart';

class ImageUsuario extends StatelessWidget {
  
  final String? url;
  
  const ImageUsuario({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 80,right: 80, top: 20,bottom: 20),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        //height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(100),),
          child: this.url == null ? 
          Image(
            image: AssetImage('assets/img/profile.png'),
            fit: BoxFit.cover,
          )
          :FadeInImage(
            placeholder: AssetImage('assets/img/jar-loading.gif'),
            image: NetworkImage(this.url!) ,
            fit:BoxFit.cover
          ),
        ),
      ), 
    );
  }

  BoxDecoration _buildBoxDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      boxShadow: [
        BoxShadow( 
          color: Colors.black.withOpacity(0.7),
          blurRadius: 10,
          spreadRadius: 12,
        )
      ]
    );
  }
}