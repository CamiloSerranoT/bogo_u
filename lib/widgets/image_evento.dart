import 'package:flutter/material.dart';

class ImageEvento extends StatelessWidget {
  
  final String? url;
  
  const ImageEvento({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10, top: 35),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        //height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          child: this.url == null ? 
          Image(
            image: AssetImage('assets/img/no-image.png'),
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
      borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
      boxShadow: [
        BoxShadow( 
          color: Colors.black.withOpacity(0.5),
          blurRadius: 10,
          spreadRadius: 5,
        )
      ]
    );
  }
}