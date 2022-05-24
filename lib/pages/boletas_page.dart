import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:bogo_u/pages/pages.dart';


class boletasPage extends StatefulWidget {
  
  boletasPage({ Key? key }) : super(key: key);
  final eventoDAO = EventoDAO();
  final boletaDAO = BoletaDAO();

  @override
  Boletas createState() => Boletas();
}

class Boletas extends State<boletasPage> {

  ScrollController _scrollController = ScrollController();
  TextEditingController eventoController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollHabiaAbajo());
    final eventoService = Provider.of<EventoService>(context);
    final authService = Provider.of<AuthService>(context, listen: false); 
    if(eventoService.isLoading) return LoadingPage();
    
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Color.fromARGB(255, 105, 16, 10),
                Color.fromARGB(255, 243, 115, 105)
              ],
            ),
          ),
        ),
        title: Text('Eventos'),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              authService.logout();
              Navigator.pushNamed(context, 'checking');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body:Padding(
        padding:EdgeInsets.all(0.0),
        child: Column(
          children: [
            _getLista(),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floatingActionButton: _Agregar(),
      bottomNavigationBar: BarraInferior(indexInit: 1),
    );
  } 

  bool _puedoEnviar() => eventoController.text.length > 0;

  void _scrollHabiaAbajo(){
    if(_scrollController.hasClients){
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Widget _getLista() {
    final eventoService = Provider.of<EventoService>(context);
    final boletaService = Provider.of<BoletaService>(context);
    final datos = Provider.of<LoginFormProvider>(context);
    bool estado = false;
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.eventoDAO.getEvento(),
        itemBuilder:(context,snapshot,animation,index){
          final json=snapshot.value as Map<dynamic,dynamic>;
          final evento=Evento.fromJson(json);
          
          estado = false;
          for(int i=0;i<boletaService.boletas.length;i++){
            if(evento.codigo == boletaService.boletas[i].idevento){
              if(datos.email == boletaService.boletas[i].idusuario){
                estado = true;
              }
            }
          }
          
          if(estado == true){
            return MaterialButton(
              disabledTextColor: Colors.black87,
              onPressed: (){
                eventoService.eventoSelect = evento;
                Navigator.pushNamed(context, 'evento');
              },
              child: CardBoletas(
                evento: evento,
              ),
            );
          }else{
             return Container();
          }
        },
      )
    );
  }
}

class _Agregar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red, 
      tooltip: 'Crear evento',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        Icons.playlist_add_rounded,
        size: 45,
        color: Colors.white,
      ),
      onPressed: (){
        Navigator.pushNamed(context, 'crearevento');
      },
    );
  }
}


