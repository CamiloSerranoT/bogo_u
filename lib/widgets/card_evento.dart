import 'package:flutter/material.dart';
import 'package:bogo_u/models/models.dart';

class CardEvento extends StatelessWidget {
  
  final Evento evento;

  const CardEvento({
    Key? key,
    required this.evento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 5),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
          _BackgroundImage(evento.imagen),
          _EventoDetails(
            nombreEvento: evento.nombre,
            valorEvento: evento.lugar,
            FechaEvento: evento.dias + ' de ' + evento.mes + ' del ' + evento.anual,
          ),
        ]),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.50),
          offset: const Offset(-10,10),
          blurRadius: 4,
        ),
      ],
    );
  }
}

class _EventoDetails extends StatelessWidget {
  
  final String nombreEvento;
  final String valorEvento;
  final String FechaEvento;

  const _EventoDetails({
    Key? key,
    required this.nombreEvento,
    required this.valorEvento,
    required this.FechaEvento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 80,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Evento: ' + nombreEvento,
              style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            Text('Lugar: ' + valorEvento,
              style: TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            Text('Fecha: ' + FechaEvento,
              style: TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(25)),
    gradient: LinearGradient(
      colors: [
      //  Colors.indigo,
      //  Colors.red
        Colors.black,
        Color.fromARGB(255, 105, 16, 10),
        Color.fromARGB(255, 243, 115, 105),
      ],
    ), 
  );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        //borderRadius: BorderRadius.circular(25),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
        child: Container(
            width: double.infinity,
            height: 400,
            child: url == null ?
            Image(
              image: AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
            )
            :FadeInImage(
              placeholder: AssetImage('assets/img/jar-loading.gif'),
              image: NetworkImage(url!),
              fit: BoxFit.cover,
            ),
          ),
        );
  }
}
