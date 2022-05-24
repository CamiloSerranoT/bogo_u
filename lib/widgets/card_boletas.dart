import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/models/models.dart';
import 'package:provider/provider.dart';

class CardBoletas extends StatelessWidget {
  
  final Evento evento;

  const CardBoletas({
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
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            //_BackgroundImage(evento.imagen),
            _EventoDetails(
              evento: evento,
            ),
          ]
        ),
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
          offset: const Offset(-12,12),
          blurRadius: 2,
          //spreadRadius: 5,
        ),
      ],
    );
  }
}

class _EventoDetails extends StatelessWidget {
  
  final Evento evento;
  late String lugarEventoString;
  late Icon icon;

  _EventoDetails({
    Key? key,
    required this.evento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lugarService = Provider.of<LugarService>(context);
    if(lugarService.isLoading) return LoadingPage();

    for(int i = 0; i<lugarService.lugares.length;i++){
      if(lugarService.lugares[i].lugar == evento.lugar){
        lugarEventoString = lugarService.lugares[i].nombre;
      }
    }

    String textEstatus = '';
    if(evento.estatus == 1){
      icon = Icon(Icons.check_circle_outline_outlined,size: 35,color: Colors.white,);
      textEstatus = 'Evento realizado';
    }else{
      icon = Icon(Icons.timelapse,size: 35,color: Colors.white,);
      textEstatus = 'Evento por realizar';
    }


    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        decoration: _buildBoxDecorationGeneral(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  children: [
                    Text('Evento: ' + evento.nombre,
                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, 
                    ),
                    Text('Lugar: ' + lugarEventoString,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, 
                    ),
                    Text('Fecha: ${evento.dias} de ${evento.mes} del ${evento.anual}',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, 
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Tooltip(
                  message: textEstatus,
                  decoration: _buildBoxDecorationToolTip(),
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {}, 
                    icon: icon,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecorationGeneral() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
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

  BoxDecoration _buildBoxDecorationToolTip() => BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
    //borderRadius: BorderRadius.circular(10),
    gradient: LinearGradient(
      colors: [
      //  Colors.indigo,
      //  Colors.red
        Colors.black,
        Color.fromARGB(255, 105, 16, 10),
        Color.fromARGB(255, 243, 115, 105),
      ],
    ), 
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.6),
        blurRadius: 10,
        spreadRadius: 5,
      ),
    ],
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
