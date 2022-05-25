import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModificarTipoPage extends StatefulWidget {
  
  ModificarTipoPage({ Key? key }) : super(key: key);
  final eventoDAO = LugarDAO();

  @override
  ModificarTipoFormPage createState() => ModificarTipoFormPage();
}

class ModificarTipoFormPage extends State<ModificarTipoPage> {

  Tipo tipo = Tipo(
    tipo: 0,
    nombre: '',
    estado: true,
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
        title: Text('Modificar tipo'),
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
            _LugarForm(tipo: tipo,),
          ],
        ),
      ),
    );
  }
}

class _LugarForm extends StatelessWidget {
  _LugarForm({
    Key? key,
    required this.tipo,
  }) : super(key: key);

  late Tipo tipo;
  
  @override
  Widget build(BuildContext context) {
    final tiposService = Provider.of<TipoService>(context);
    if(tiposService.isLoading) return LoadingPage();
    
    List<String> listaDesplegableTipos = [];
    for(int i=0;i<tiposService.tipos.length;i++){
      listaDesplegableTipos.add('${tiposService.tipos[i].nombre}');
    }
    var vistaListTipos = listaDesplegableTipos[0];

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
                'Seleccione el tipo a modificar',
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
                    child: _ListaDesplegableLugares(tipo,listaDesplegableTipos,vistaListTipos),
                  ),
                ),
              ),
              SizedBox(height: 40,),
            ],
          )
        ),
      ),
    );
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
    this.tipo,
    this.listaDesplegable,
    this.vistaList,
  );

  late Tipo tipo;
  late List<String> listaDesplegable = [];
  late var vistaList = '';
  
  @override
  _ListaDesplegableLugaresForm createState() => _ListaDesplegableLugaresForm(tipo,listaDesplegable,vistaList);
}

class _ListaDesplegableLugaresForm extends State<_ListaDesplegableLugares> {
  
  _ListaDesplegableLugaresForm(
    this.tipo,
    this.listaDesplegable,
    this.vistaList,
  );
  
  late Tipo tipo;
  late List<String> listaDesplegable = [];
  late var vistaList;

  @override
  Widget build(BuildContext context) {
    final tiposService = Provider.of<TipoService>(context);

    for(int i=0;i<tiposService.tipos.length;i++){
      if(tiposService.tipos[i].nombre == vistaList){
        tipo = tiposService.tipos[i];
      }
    }
    tiposService.tipoSelect = tipo;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child:  Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButton<String>(
              alignment: Alignment.center,
              icon: Icon(Icons.keyboard_double_arrow_down_sharp,color: Colors.white,),
              dropdownColor: Colors.grey.withOpacity(0.8),
              items: listaDesplegable.map<DropdownMenuItem<String>>((String value13){
                return DropdownMenuItem<String>( 
                  alignment: Alignment.center,
                  value: value13,
                  child: Text(
                    value13,
                    style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                  ), 
                ); 
              }).toList(),
            
              onChanged: (value13) => {
                vistaList = value13,
                setState(() {
                 
                }),
              },
              value: vistaList,
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
                  'Seleccionar',
                  style: TextStyle(fontSize: 20,color: Colors.black,),              
                ),
              ),
              onPressed: (){
                tiposService.tipoSelect = tipo;
                Navigator.pushNamed(context, 'modificartipoformat');
              },
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
