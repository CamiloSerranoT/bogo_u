import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:provider/provider.dart';

class EliminarLugarPage extends StatefulWidget {
  
  EliminarLugarPage({ Key? key }) : super(key: key);
  final eventoDAO = LugarDAO();

  @override
  EliminarLugarFormPage createState() => EliminarLugarFormPage();
}

class EliminarLugarFormPage extends State<EliminarLugarPage> {

  Lugar lugar = Lugar(
    lugar: 0,
    nombre: '',
    direccion: '',
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
        title: Text('Eliminar lugar'),
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
            _LugarForm(lugar: lugar,),
          ],
        ),
      ),
    );
  }
}

class _LugarForm extends StatelessWidget {
  _LugarForm({
    Key? key,
    required this.lugar,
  }) : super(key: key);

  final lugarDAO = LugarDAO(); 
  late Lugar lugar;
  
  @override
  Widget build(BuildContext context) {
    final lugarService = Provider.of<LugarService>(context);
    if(lugarService.isLoading) return LoadingPage();
    
    List<String> listaDesplegableLugares = [];
    for(int i=0;i<lugarService.lugares.length;i++){
      listaDesplegableLugares.add('${lugarService.lugares[i].nombre}');
    }
    var vistaListLugares = listaDesplegableLugares[0];

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
              Text(
                'Seleccione el lugar a eliminar',
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center, 
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.0),
                        offset: const Offset(0,0),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: ChangeNotifierProvider(
                    create: (_) {},
                    child: _ListaDesplegableLugares(lugar,listaDesplegableLugares,vistaListLugares),
                  ),
                ),
              ),
              SizedBox(height: 40,),
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
                      'Eliminar',
                      style: TextStyle(fontSize: 20,color: Colors.black,),              
                    ),
                  ),
                  onPressed: (){
                    _eliminarLugar();
                    lugarService.actualizar();
                    Navigator.pushNamed(context, 'crearevento');
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

  void _eliminarLugar() {
    lugarDAO.eliminarLugar(lugar.id!);
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

class _ListaDesplegableLugares extends StatefulWidget{
  
  _ListaDesplegableLugares(
    this.lugar,
    this.listaDesplegable,
    this.vistaList,
  );

  late Lugar lugar;
  late List<String> listaDesplegable = [];
  late var vistaList = '';
  
  @override
  _ListaDesplegableLugaresForm createState() => _ListaDesplegableLugaresForm(lugar,listaDesplegable,vistaList);
}

class _ListaDesplegableLugaresForm extends State<_ListaDesplegableLugares> {
  
  _ListaDesplegableLugaresForm(
    this.lugar,
    this.listaDesplegable,
    this.vistaList,
  );
  
  late Lugar lugar;
  late List<String> listaDesplegable = [];
  late var vistaList;

  @override
  Widget build(BuildContext context) {
    final lugarService = Provider.of<LugarService>(context);
    for(int i=0;i<lugarService.lugares.length;i++){
      if(lugarService.lugares[i].nombre == vistaList){
        lugar.id = '${lugarService.lugares[i].id}';
      }
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButton<String>(
              alignment: Alignment.center,
              icon: Icon(Icons.keyboard_double_arrow_down_sharp,color: Colors.white,),
              dropdownColor: Colors.grey.withOpacity(0.8),
              items: listaDesplegable.map<DropdownMenuItem<String>>((String value10){
                return DropdownMenuItem<String>( 
                  alignment: Alignment.center,
                  value: value10,
                  child: Text(
                    value10,
                    style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                  ), 
                ); 
              }).toList(),
            
              onChanged: (value10) => {
                vistaList = value10,
                setState(() {}),
                },
              value: vistaList,
            ),
          ),
        ],
      ),
    );
  }
}
