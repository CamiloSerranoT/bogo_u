import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CrearEventoPage extends StatefulWidget {
  
  CrearEventoPage({ Key? key }) : super(key: key);
  final eventoDAO = EventoDAO();

  @override
  CrearEventoFormPage createState() => CrearEventoFormPage();
}

class CrearEventoFormPage extends State<CrearEventoPage> {

  ScrollController _scrollController = ScrollController();
  TextEditingController eventoController = TextEditingController();

  Evento evento = Evento(
      anual: '', 
      apertura: '', 
      descripcion: '', 
      dias: '', 
      estado: true, 
      inicio: '', 
      lugar: 0, 
      mes: '', 
      nombre: '', 
      tipo: 0, 
      valor: 0
    );

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); 
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
        title: Text('Crear evento'),
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
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            _EventoForm(evento: evento,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //floatingActionButton: _AgregarButton(),
    );
  }

  _AgregarButton() {
    @override
    Widget build(BuildContext context) {
      return FloatingActionButton(
        backgroundColor: Colors.red, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Icons.save_outlined,
          size: 45,
          color: Colors.white,
        ),
        onPressed: (){

        },
      );
    }
  }
}

class _EventoForm extends StatelessWidget {
  _EventoForm({
    Key? key,
    required this.evento,
  }) : super(key: key);

  final eventoDAO = EventoDAO(); 
  late Evento evento;
  
  @override
  Widget build(BuildContext context) {
    final lugarService = Provider.of<LugarService>(context);
    final tipoService = Provider.of<TipoService>(context);
    String lugarText = 'Nota: Digitar solo el numero del lugar\nINFORMACIÓN:\n';
    String tipoText = 'Nota: Digitar solo el numero del tipo\nINFORMACIÓN:\n';
    
    // Parte de listado de lugares
    if(lugarService.isLoading) return LoadingPage();
    for(int i = 0; i<lugarService.lugares.length;i++){
      lugarText = '${lugarText} ${lugarService.lugares[i].lugar} --> ${lugarService.lugares[i].nombre} \n' ;
    }

    // Parte de listado de tipos
    if(tipoService.isLoading) return LoadingPage();
    for(int i = 0; i<tipoService.tipos.length;i++){
      tipoText = '${tipoText} ${tipoService.tipos[i].tipo} --> ${tipoService.tipos[i].nombre} \n' ;
    }

    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                initialValue: '${evento.nombre}',
                keyboardType: TextInputType.text,
                onChanged: ( value ) => evento.nombre = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El nombre es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'Nombre del Evento',
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: ( value ) => evento.lugar = int.parse(value),
                        validator: ( value ) {
                          if(value == null || value.length < 1){
                            return 'El nombre es obligatorio';
                          }
                        },
                        style: const TextStyle(fontSize: 18,color: Colors.white,),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: InputDecorations.authInputDecorationGeneral(
                          hintText: '', 
                          labelText: 'Lugar evento',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                      child: IconButton(
                        onPressed: () {
                          
                        }, 
                        icon: Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              lugarText,
                              style: TextStyle(fontSize: 15,color: Colors.black,),
                            ),
                            action: SnackBarAction(
                              label: 'Ocultar',
                              textColor: Colors.red,
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }, 
                        icon: Icon(
                          Icons.info,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: ( value ) => evento.tipo = int.parse(value),
                        style: const TextStyle(fontSize: 18,color: Colors.white,),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        validator: ( value ) {
                          if(value == null || value.length < 1){
                            return 'El nombre es obligatorio';
                          }
                        },
                        decoration: InputDecorations.authInputDecorationGeneral(
                          hintText: '', 
                          labelText: 'Tipo evento',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IconButton(
                      onPressed: () {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            tipoText,
                            style: TextStyle(fontSize: 15,color: Colors.black,),
                          ),
                          action: SnackBarAction(
                            label: 'Ocultar',
                            textColor: Colors.red,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }, 
                      icon: Icon(
                        Icons.info,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: '${evento.valor}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+$'))
                ],
                onChanged: ( value ) => evento.valor = int.parse(value),
                keyboardType: TextInputType.number, // Deja solo teclado numerico 
                style: const TextStyle(fontSize: 22,color: Colors.white,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '',
                  labelText: 'Valor boleta',
                ),
              ),
              SizedBox(height: 20,),
              Wrap(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      initialValue: '${evento.apertura}',
                      onChanged: ( value ) => evento.apertura = value,
                      keyboardType: TextInputType.text, // Deja solo teclado numerico 
                      style: const TextStyle(fontSize: 18,color: Colors.white,),
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: InputDecorations.authInputDecorationGeneral(
                        hintText: '00:00',
                        labelText: 'Hora de apertura',
                      ),
                      validator: ( value ) {
                        if(value == null || value.length < 1){
                          return 'La hora de apertura es obligatoria';
                        }
                      }, 
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextFormField(
                      initialValue: '${evento.inicio}',
                      onChanged: ( value ) => evento.inicio = value,
                      keyboardType: TextInputType.text, // Deja solo teclado numerico 
                      style: const TextStyle(fontSize: 18,color: Colors.white,),
                      textAlign: TextAlign.center,
                      decoration: InputDecorations.authInputDecorationGeneral(
                        hintText: '00:00',
                        labelText: 'Hora de inicio',
                      ),
                      validator: ( value ) {
                        if(value == null || value.length < 1){
                          return 'La hora de apertura es obligatoria';
                        }
                      }, 
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextFormField(
                        initialValue: '${evento.dias}',
                        onChanged: ( value ) => evento.dias = value,
                        keyboardType: TextInputType.text, // Deja solo teclado numerico 
                        style: const TextStyle(fontSize: 15,color: Colors.white,),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: InputDecorations.authInputDecorationGeneral(
                          hintText: '',
                          labelText: 'Dias',
                        ),
                        validator: ( value ) {
                          if(value == null || value.length < 1){
                            return 'El o los dias son obligatorios';
                          }
                        }, 
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextFormField(
                        initialValue: '${evento.mes}',
                        onChanged: ( value ) => evento.mes = value,
                        keyboardType: TextInputType.text, // Deja solo teclado numerico 
                        style: const TextStyle(fontSize: 15,color: Colors.white,),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: InputDecorations.authInputDecorationGeneral(
                          hintText: '',
                          labelText: 'Mes',
                        ),
                        validator: ( value ) {
                          if(value == null || value.length < 1){
                            return 'El mes es obligatorio';
                          }
                        }, 
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextFormField(
                        initialValue: '${evento.anual}',
                        onChanged: ( value ) => evento.anual = value,
                        keyboardType: TextInputType.text, // Deja solo teclado numerico 
                        style: const TextStyle(fontSize: 15,color: Colors.white,),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: InputDecorations.authInputDecorationGeneral(
                          hintText: '',
                          labelText: 'Año',
                        ),
                        validator: ( value ) {
                          if(value == null || value.length < 1){
                            return 'El año es obligatorio';
                          }
                        }, 
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: '${evento.descripcion}',
                onChanged: ( value ) => evento.descripcion = value,
                keyboardType: TextInputType.text, // Deja solo teclado numerico 
                style: const TextStyle(fontSize: 16,color: Colors.white,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                maxLines: 8,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: 'Descripción',
                  labelText: 'Información General'
                ),
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'La descripción es obligatorio';
                  }
                }, 
              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: ( value ) => evento.imagen = value,
                style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'URL imagen(Opcional)',
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  disabledColor: Colors.white,
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Crear',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    if(_puedoEnviar()) {
                      print(evento.dias);
                      print(evento.valor);
                      _envierEvento();
                      Navigator.pushNamed(context, 'principal');
                    }
                  },
                ),
              ),
              SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }

  bool _puedoEnviar(){
    return true;
  }

  void _envierEvento() {
    eventoDAO.guardarEvento(evento);
    //eventoController.clear();
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    gradient: LinearGradient(
      colors: [
      //  Colors.indigo,
      //  Colors.red
        Colors.black.withOpacity(0.85),
        Color.fromARGB(255, 105, 16, 10).withOpacity(0.9),
        Color.fromARGB(255, 243, 115, 105),
        Color.fromARGB(255, 105, 16, 10).withOpacity(0.9),
        Colors.black.withOpacity(0.85),
      ],
    ), 
    boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 10,
          spreadRadius: 5,
        ),
      ],
  );

}
