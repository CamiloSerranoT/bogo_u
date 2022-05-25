import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';

class ModificarImagenEventoPage extends StatefulWidget {
  
  ModificarImagenEventoPage({ Key? key }) : super(key: key);
  final eventoDAO = LugarDAO();

  @override
  ModificarImagenEventoFormPage createState() => ModificarImagenEventoFormPage();
}

class ModificarImagenEventoFormPage extends State<ModificarImagenEventoPage> {

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
      valor: 0,
      estatus: 2,
      codigo: 0,
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
        title: Text(
          'Modificar imagen',
          style: const TextStyle(fontSize: 25,color: Colors.white,),
        ),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, 'principal');
            },
            icon: Icon(Icons.menu),
          ),
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
            _LugarForm(evento: evento,),
          ],
        ),
      ),
    );
  }
}

class _LugarForm extends StatelessWidget {
  _LugarForm({
    Key? key,
    required this.evento,
  }) : super(key: key);

  final eventoDAO = EventoDAO(); 
  late Evento evento;
  
  @override
  Widget build(BuildContext context) {
    final eventoService = Provider.of<EventoService>(context);
    if(eventoService.isLoading) return LoadingPage();
    
    evento = eventoService.eventoSelect;

    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                onChanged: ( value ) => evento.imagen = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El enlace es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '', 
                  labelText: 'Enlace del evento',
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
                      'Eliminar imagen actual',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    if(evento.imagen == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('OBSERVACIÓN\nNo tenia imagen, por lo cual no se puede llevar a cabo esta acción.'));
                      Navigator.pushNamed(context, 'principal');
                    }else{
                      evento.imagen = null;
                      _modificarImagenEvento(evento);
                      eventoService.actualizar();
                      Navigator.pushNamed(context, 'principal');
                    }
                  },
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
                      'Modificar',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    if(evento.nombre == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca la URL de la imagen'));
                    }else{
                      _modificarImagenEvento(evento);
                      eventoService.actualizar();
                      Navigator.pushNamed(context, 'principal');
                    }
                  },
                ),
              ),
              SizedBox(height: 40,),
            ],
          )
        ),
      ),
    );
  }

  void _modificarImagenEvento(Evento evento) {
    eventoDAO.modificarTodoEvento(evento.id!,evento);
  }

  SnackBar _Error(fraseo){    
    final snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          fraseo,
          style: TextStyle(fontSize: 15,color: Colors.black,),
        ),
        action: SnackBarAction(
          label: 'Ocultar',
          textColor: Colors.red,
          onPressed: () {},
        ),
      );
    return snackBar;
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
