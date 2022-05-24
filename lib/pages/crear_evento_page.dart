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
    );
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
    final eventoService = Provider.of<EventoService>(context);
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

    List<String> listaDesplegableMes = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
    var vistaListMes = listaDesplegableMes[0];
    String vistaListMesAux = listaDesplegableMes[0];

    List<String> listaDesplegableAnual = [];
    List<int> fechas = [2022,2040]; 
    for(int i=0;i<=fechas[1]-fechas[0];i++){
      listaDesplegableAnual.add('${fechas[0]+i}');
    }
    var vistaListAnual = listaDesplegableAnual[0];
    
    List<String> listaDesplegableDia = [];
    for(int i=1;i<=31;i++){
      listaDesplegableDia.add('${i}');
    }
    var vistaListDia = listaDesplegableDia[0];
    late List<int> listaDesplegableDiasCont = [31,28,31,30,31,30,31,31,30,31,30,31];

    List<String> listaDesplegableMinAper = [];
    List<String> listaDesplegableMinIni = [];
    for(int i=0;i<=59;i++){
      if(i >= 0 && i <= 9){
        listaDesplegableMinAper.add('0${i}');
        listaDesplegableMinIni.add('0${i}');
      }else{
        listaDesplegableMinAper.add('${i}');
        listaDesplegableMinIni.add('${i}');
      }
    }
    var vistaListMinAper = listaDesplegableMinAper[0];
    var vistaListMinIni = listaDesplegableMinIni[0];

    List<String> listaDesplegableHorAper = [];
    List<String> listaDesplegableHorIni = [];
    for(int i=0;i<=23;i++){
      if(i >= 0 && i <= 9){
        listaDesplegableHorAper.add('0${i}');
        listaDesplegableHorIni.add('0${i}');
      }
      else{
        listaDesplegableHorAper.add('${i}');
        listaDesplegableHorIni.add('${i}');
      }
    }
    var vistaListHorAper = listaDesplegableHorAper[0];
    var vistaListHorIni = listaDesplegableHorIni[0];

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
                            return 'El lugar es obligatorio';
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
                          Navigator.pushNamed(context, 'crearlugar');
                        }, 
                        icon: Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
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
                            return 'El tipo es obligatorio';
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
                    padding: const EdgeInsets.only(left: 5.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'creartipo');
                        }, 
                        icon: Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
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
              SizedBox(height: 25,),
              TextFormField(
                initialValue: '${evento.valor}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+$'))
                ],
                onChanged: ( value ) => evento.valor = int.parse(value),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 22,color: Colors.white,),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationGeneral(
                  hintText: '',
                  labelText: 'Valor boleta',
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.only(right: 10,left: 10,bottom: 5.0,top: 3.0),
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
                        child: _ListaDesplegableAper(evento,listaDesplegableHorAper,vistaListHorAper,listaDesplegableMinIni,vistaListMinAper),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.only(right: 10,left: 10,bottom: 5.0,top: 3.0),
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
                        child: _ListaDesplegableIni(evento,listaDesplegableHorIni,vistaListHorIni,listaDesplegableMinIni,vistaListMinIni),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.only(right: 10,left: 10,top: 3,bottom: 3),
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
                    child: _ListaDesplegableMes(listaDesplegableMes,vistaListMes,evento,listaDesplegableDia,vistaListDia,listaDesplegableAnual,vistaListAnual,listaDesplegableDiasCont,vistaListMesAux),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: '${evento.descripcion}',
                onChanged: ( value ) => evento.descripcion = value,
                keyboardType: TextInputType.multiline, // Deja solo teclado numerico 
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
                    var aper = evento.apertura.split(':');
                    var ini = evento.inicio.split(':');  
                    if(evento.nombre.length < 1 || evento.nombre == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca un nombre del evento'));
                    }else if(evento.lugar < 1 || evento.lugar > lugarService.lugares.length || evento.lugar == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca un codigo de lugar.\nRevise el icono de información al lado derecho del campo.'));
                    }else if(evento.tipo < 1 || evento.tipo > tipoService.tipos.length || evento.tipo == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca un codigo de tipo.\nRevise el icono de información al lado derecho del campo.'));
                    }else if(int.parse(aper[0]) > int.parse(ini[0])){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nLa hora de apertura no puede ser posterior a la de inicio'));
                    }else if(int.parse(aper[0]) == int.parse(ini[1])){
                      if(int.parse(aper[1]) >= int.parse(ini[1])){
                        ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nEl minuto de apertura no puede ser posterior o igual al de inicio'));
                      }
                    }else if(evento.descripcion.length < 1 || evento.descripcion == null){
                      ScaffoldMessenger.of(context).showSnackBar(_Error('ERROR\nPor favor introduzca una descripcion del evento'));
                    }else{  
                      evento.codigo= eventoService.eventos.length + 1;
                      _enviarEvento();
                      eventoService.actualizar();
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

  SnackBar _Error(fraseo){    
    final snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          fraseo,
          style: TextStyle(fontSize: 15,color: Colors.black),
        ),
        action: SnackBarAction(
          label: 'Ocultar',
          textColor: Colors.red,
          onPressed: () {},
        ),
      );
    return snackBar;
  }

  void _enviarEvento() {
    eventoDAO.guardarEvento(evento);
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

class _ListaDesplegableMes extends StatefulWidget{
  
  _ListaDesplegableMes(
    this.listaDesplegable,
    this.vistaList,
    this.evento,
    this.listaDesplegableDia,
    this.vistaListDia,
    this.listaDesplegableAnual,
    this.vistaListAnual,
    this.listaDesplegableDiasCont,
    this.vistaListMesAux,
  );

  late List<String> listaDesplegable = [];
  late var vistaList = '';
  late String vistaListMesAux = '';
  late Evento evento;
  late List<String> listaDesplegableDia = [];
  late var vistaListDia = '';
  late List<String> listaDesplegableAnual = [];
  late var vistaListAnual = '';
  late List<int> listaDesplegableDiasCont = [];
  bool estadoMes = true;
  
  @override
  _ListaDesplegableMesForm createState() => _ListaDesplegableMesForm(listaDesplegable, vistaList, evento,listaDesplegableDia,vistaListDia,listaDesplegableAnual,vistaListAnual,listaDesplegableDiasCont,vistaListMesAux,estadoMes);
}

class _ListaDesplegableMesForm extends State<_ListaDesplegableMes> {
  
  _ListaDesplegableMesForm(
    this.listaDesplegable,
    this.vistaList,
    this.evento,
    this.listaDesplegableDia,
    this.vistaListDia,
    this.listaDesplegableAnual,
    this.vistaListAnual,
    this.listaDesplegableDiasCont,
    this.vistaListMesAux,
    this.estadoMes,
  );
  
  late List<String> listaDesplegable = [];
  late var vistaList;
  late String vistaListMesAux;
  late Evento evento;
  late List<String> listaDesplegableDia = [];
  late var vistaListDia;
  late List<String> listaDesplegableAnual = [];
  late var vistaListAnual;
  late List<int> listaDesplegableDiasCont;
  bool estadoMes;

  @override
  Widget build(BuildContext context) {
    evento.mes = vistaList;
    evento.anual = vistaListAnual;
    
    if(!(vistaListMesAux == vistaList)){
      for(int i=0;i<listaDesplegable.length;i++){
        if(evento.mes == listaDesplegable[i]){
          listaDesplegableDia=[];
          for(int j=1;j<=listaDesplegableDiasCont[i];j++){
            listaDesplegableDia.add('${j}');
          }
          vistaListMesAux=vistaList;
        }
      }
      vistaListDia=listaDesplegableDia[0];
    }
    evento.dias = vistaListDia;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text(
            'Fecha del evento',
            style: const TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegableDia.map<DropdownMenuItem<String>>((String value2){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value2,
                      child: Text(
                        value2,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                  onChanged: (value2) => {
                    vistaListDia = value2,
                    setState(() {}),
                    },
                  value: vistaListDia,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0.0,left: 0.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegable.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                
                  onChanged: (value) => {
                    vistaList = value,
                    setState(() {}),
                    },
                  value: vistaList,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 20.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegableAnual.map<DropdownMenuItem<String>>((String value3){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value3,
                      child: Text(
                        value3,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                
                  onChanged: (value3) => {
                    vistaListAnual = value3,
                    setState(() {}),
                    },
                  value: vistaListAnual,
                ),
              ),
            ],
          ),
        ],
        
      ),
    );
  }
}

class _ListaDesplegableAper extends StatefulWidget{
  
  _ListaDesplegableAper(
    this.evento,
    this.listaDesplegableHor,
    this.vistaListHor,
    this.listaDesplegableMin,
    this.vistaListMin,
  );

  late Evento evento;
  late List<String> listaDesplegableHor = [];
  late var vistaListHor = '';
  late List<String> listaDesplegableMin = [];
  late var vistaListMin = '';
  
  @override
  _ListaDesplegableAperForm createState() => _ListaDesplegableAperForm(evento,listaDesplegableHor,vistaListHor,listaDesplegableMin,vistaListMin);
}

class _ListaDesplegableAperForm extends State<_ListaDesplegableAper> {
  
  _ListaDesplegableAperForm(
    this.evento,
    this.listaDesplegableHor,
    this.vistaListHor,
    this.listaDesplegableMin,
    this.vistaListMin,
  );
  
  late Evento evento;
  late List<String> listaDesplegableHor = [];
  late var vistaListHor;
  late List<String> listaDesplegableMin = [];
  late var vistaListMin;

  @override
  Widget build(BuildContext context) {
    evento.apertura = '${vistaListHor}:${vistaListMin}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child:  Column(
        children: [
          SizedBox(height: 10,),
          Text(
            'Hora apertura',
            style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0.0,left: 0.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegableHor.map<DropdownMenuItem<String>>((String value5){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value5,
                      child: Text(
                        value5,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                
                  onChanged: (value5) => {
                    vistaListHor = value5,
                    setState(() {}),
                    },
                  value: vistaListHor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Text(
                  ':',
                  style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegableMin.map<DropdownMenuItem<String>>((String value6){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value6,
                      child: Text(
                        value6,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                
                  onChanged: (value6) => {
                    vistaListMin = value6,
                    setState(() {}),
                    },
                  value: vistaListMin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListaDesplegableIni extends StatefulWidget{
  
  _ListaDesplegableIni(
    this.evento,
    this.listaDesplegableHor,
    this.vistaListHor,
    this.listaDesplegableMin,
    this.vistaListMin,
  );

  late Evento evento;
  late List<String> listaDesplegableHor = [];
  late var vistaListHor = '';
  late List<String> listaDesplegableMin = [];
  late var vistaListMin = '';
  
  @override
  _ListaDesplegableIniForm createState() => _ListaDesplegableIniForm(evento,listaDesplegableHor,vistaListHor,listaDesplegableMin,vistaListMin);
}

class _ListaDesplegableIniForm extends State<_ListaDesplegableIni> {
  
  _ListaDesplegableIniForm(
    this.evento,
    this.listaDesplegableHor,
    this.vistaListHor,
    this.listaDesplegableMin,
    this.vistaListMin,
  );
  
  late Evento evento;
  late List<String> listaDesplegableHor = [];
  late var vistaListHor;
  late List<String> listaDesplegableMin = [];
  late var vistaListMin;

  @override
  Widget build(BuildContext context) {
    evento.inicio = '${vistaListHor}:${vistaListMin}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child:  Column(
        children: [
          SizedBox(height: 10,),
          Text(
            'Hora inicio',
            style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0.0,left: 0.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegableHor.map<DropdownMenuItem<String>>((String value8){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value8,
                      child: Text(
                        value8,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                
                  onChanged: (value8) => {
                    vistaListHor = value8,
                    setState(() {}),
                    },
                  value: vistaListHor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Text(
                  ':',
                  style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  dropdownColor: Colors.grey.withOpacity(0.8),
                  items: listaDesplegableMin.map<DropdownMenuItem<String>>((String value9){
                    return DropdownMenuItem<String>( 
                      alignment: Alignment.center,
                      value: value9,
                      child: Text(
                        value9,
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ), 
                    ); 
                  }).toList(),
                
                  onChanged: (value9) => {
                    vistaListMin = value9,
                    setState(() {}),
                    },
                  value: vistaListMin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
