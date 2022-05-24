import 'package:bogo_u/dao/dao.dart';
import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EliminarTipoPage extends StatefulWidget {
  
  EliminarTipoPage({ Key? key }) : super(key: key);
  final eventoDAO = LugarDAO();

  @override
  EliminarTipoFormPage createState() => EliminarTipoFormPage();
}

class EliminarTipoFormPage extends State<EliminarTipoPage> {

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
            _TipoForm(tipo: tipo,),
          ],
        ),
      ),
    );
  }
}

class _TipoForm extends StatelessWidget {
  _TipoForm({
    Key? key,
    required this.tipo,
  }) : super(key: key);

  final tipoDAO = TipoDAO(); 
  late Tipo tipo;
  
  @override
  Widget build(BuildContext context) {
    final tipoService = Provider.of<TipoService>(context);
    if(tipoService.isLoading) return LoadingPage();
    
    List<String> listaDesplegableTipos = [];
    for(int i=0;i<tipoService.tipos.length;i++){
      listaDesplegableTipos.add('${tipoService.tipos[i].nombre}');
    }
    var vistaLisTipos = listaDesplegableTipos[0];

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
                'Seleccione el tipo a eliminar',
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Container(
                  margin: EdgeInsets.all(0),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
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
                    child: _ListaDesplegableTipos(tipo,listaDesplegableTipos,vistaLisTipos),
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
                    _eliminarTipo();
                    tipoService.actualizar();
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

  void _eliminarTipo() {
    tipoDAO.eliminarTipo(tipo.id!);
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

class _ListaDesplegableTipos extends StatefulWidget{
  
  _ListaDesplegableTipos(
    this.tipo,
    this.listaDesplegable,
    this.vistaList,
  );

  late Tipo tipo;
  late List<String> listaDesplegable = [];
  late var vistaList = '';
  
  @override
  _ListaDesplegableTiposForm createState() => _ListaDesplegableTiposForm(tipo,listaDesplegable,vistaList);
}

class _ListaDesplegableTiposForm extends State<_ListaDesplegableTipos> {
  
  _ListaDesplegableTiposForm(
    this.tipo,
    this.listaDesplegable,
    this.vistaList,
  );
  
  late Tipo tipo;
  late List<String> listaDesplegable = [];
  late var vistaList;

  @override
  Widget build(BuildContext context) {
    final tipoService = Provider.of<TipoService>(context);
    for(int i=0;i<tipoService.tipos.length;i++){
      if(tipoService.tipos[i].nombre == vistaList){
        tipo.id = '${tipoService.tipos[i].id}';
      }
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      width: double.infinity,

      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButton<String>(
              alignment: Alignment.center,
              icon: Icon(Icons.keyboard_double_arrow_down_sharp,color: Colors.white,),
              dropdownColor: Colors.grey.withOpacity(0.8),
              items: listaDesplegable.map<DropdownMenuItem<String>>((String value11){
                return DropdownMenuItem<String>( 
                  alignment: Alignment.center,
                  value: value11,
                  child: Text(
                    value11,
                    style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                  ), 
                ); 
              }).toList(),
            
              onChanged: (value11) => {
                vistaList = value11,
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
