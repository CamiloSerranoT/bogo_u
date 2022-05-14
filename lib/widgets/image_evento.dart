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
      padding: EdgeInsets.only(left: 0,right: 0, top: 23),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        //height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(0)),
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
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0,5),
        )
      ]
    );
  }
}