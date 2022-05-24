import 'package:bogo_u/models/models.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/providers/providers.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/uis.dart';
import 'package:bogo_u/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EventoPage extends StatelessWidget {
  const EventoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventoService = Provider.of<EventoService>(context);
    return ChangeNotifierProvider(
      create: ( _ ) => EventoFormProvider(eventoService.eventoSelect),
      child: _EventoPageBody(eventoService: eventoService),
    );
  }
}

class _EventoPageBody extends StatelessWidget {
  const _EventoPageBody({
    Key? key,
    required this.eventoService,
  }) : super(key: key);

  final EventoService eventoService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ImageEvento(url: eventoService.eventoSelect.imagen),
                Positioned(
                  top: 40,
                  left: 5,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white),
                  )
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                  )
                )
              ],  
            ),
            _EventoForm()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _AgregarButton(),
    );
  }
}

class _EventoForm extends StatelessWidget {
  _EventoForm({
    Key? key,
  }) : super(key: key);

  late Lugar lugar;
  late Tipo tipo = Tipo(estado: true, nombre: '', tipo: 0);
  
  @override
  Widget build(BuildContext context) {
    final eventoForm = Provider.of<EventoFormProvider>(context);
    final evento = eventoForm.evento;
    final lugarService = Provider.of<LugarService>(context);
    final tipoService = Provider.of<TipoService>(context);
    
    // Parte de listado de lugares
    if(lugarService.isLoading) return LoadingPage();
    List<String> listaDesplegable = []; 
    var vistaList;
    for(int i = 0; i<lugarService.lugares.length;i++){
      if(lugarService.lugares[i].lugar == evento.lugar){
        lugar = lugarService.lugares[i];
      }
      listaDesplegable.add(lugarService.lugares[i].nombre);
    }
    vistaList = lugar.nombre; // Edición de datos de Lista desplegable lugares

    // Parte de listado de tipos
    if(tipoService.isLoading) return LoadingPage();
    List<String> listaDesplegableTipo = []; 
    var vistaListTipos;
    for(int i = 0; i<tipoService.tipos.length;i++){
      if(tipoService.tipos[i].tipo == evento.tipo){
        tipo = tipoService.tipos[i];
      }
      listaDesplegableTipo.add(tipoService.tipos[i].nombre);
    }
    vistaListTipos = tipo.nombre; // Edición de datos de Lista desplegable lugares
    
    List<String> listaDesplegableMes = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
    var vistaListMes = evento.mes;
    String vistaListMesAux = evento.mes;

    List<String> listaDesplegableAnual = [];
    List<int> fechas = [2022,2040]; 
    for(int i=0;i<=fechas[1]-fechas[0];i++){
      listaDesplegableAnual.add('${fechas[0]+i}');
    }
    var vistaListAnual = evento.anual;
    
    List<String> listaDesplegableDia = [];
    for(int i=1;i<=31;i++){
      listaDesplegableDia.add('${i}');
    }
    var vistaListDia = evento.dias;
    late List<int> listaDesplegableDiasCont = [31,28,31,30,31,30,31,31,30,31,30,31];

    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 0,),
              TextFormField(
                initialValue: evento.nombre,
                keyboardType: TextInputType.text,
                onChanged: ( value ) => evento.nombre = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El nombre es obligatorio';
                  }
                }, 
                style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecorations.authInputDecorationEvento(
                  hintText: 'Nombre del Evento', 
                  labelText: '',
                ),
              ),
              SizedBox(height: 0,),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                alignment: Alignment.center, 
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.50),
                      offset: const Offset(0,0),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ChangeNotifierProvider(
                  create: (_) {},
                  child: _ListaDesplegable(listaDesplegable,vistaList,evento, lugar),
                ),
              ),
              SizedBox(height: 0,),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                alignment: Alignment.center, 
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.50),
                      offset: const Offset(0,0),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ChangeNotifierProvider(
                  create: (_) {},
                  child: _ListaDesplegableTipo(listaDesplegableTipo,vistaListTipos,evento),
                ),
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
                  hintText: 'Valor boleta',
                  labelText: 'Valor boleta',
                ),
              ),
              SizedBox(height: 30,),
              Wrap(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
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
                    width: MediaQuery.of(context).size.width * 0.4,
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
              SizedBox(height: 15,),
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
              /*SizedBox(height: 15,),
              SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible',style: TextStyle(color: Colors.white),),
                activeColor: Colors.white, 
                onChanged: eventoForm.updateEstado,
              ),*/
              SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    //color: Colors.indigo,
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(20)
    ),
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
class _AgregarButton extends StatelessWidget {
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

class _ListaDesplegable extends StatefulWidget{
  
  _ListaDesplegable(
    this.listaDesplegable,
    this.vistaList,
    this.evento,
    this.lugar,
  );
  
  late List<String> listaDesplegable = [];
  late var vistaList;
  late Evento evento;
  late Lugar lugar;

  @override
  State createState() => _ListaDesplegableForm(listaDesplegable, vistaList, evento,lugar);
}

class _ListaDesplegableForm extends State<_ListaDesplegable> {
  
  _ListaDesplegableForm(
    this.listaDesplegable,
    this.vistaList,
    this.evento,
    this.lugar,
  );
  
  late List<String> listaDesplegable = [];
  late var vistaList;
  late Evento evento;
  late Lugar lugar;
  late String dir = '';

  @override
  Widget build(BuildContext context) {
    final lugarService = Provider.of<LugarService>(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          DropdownButton<String>(
            alignment: Alignment.center,
            icon: Icon(Icons.keyboard_double_arrow_down_outlined,color: Colors.black),
            items: listaDesplegable.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>( 
                alignment: Alignment.center,
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ), 
              ); 
            }).toList(),
          
            onChanged: (value) => {
              vistaList = value,
              setState(() {
                for(int i = 0; i<listaDesplegable.length;i++){
                  if(value == listaDesplegable[i]){
                    evento.lugar = i + 1;
                    lugar = lugarService.lugares[i];
                  }
                }
              }),
            },
            value: vistaList,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      offset: const Offset(0,0),
                      blurRadius: 2,
                    ),
                  ],
                ),
            child: Text(
              lugar.direccion,
              style: const TextStyle(fontSize: 18,color: Colors.black,),
            ),
          ),
        ],
      ),
    );
  }


}

class _ListaDesplegableTipo extends StatefulWidget{
  
  _ListaDesplegableTipo(
    this.listaDesplegable,
    this.vistaList,
    this.evento,
  );
  
  late List<String> listaDesplegable = [];
  late var vistaList;
  late Evento evento;
  
  @override
  State createState() => _ListaDesplegableTipoForm(listaDesplegable, vistaList, evento);
}

class _ListaDesplegableTipoForm extends State<_ListaDesplegableTipo> {
  
  _ListaDesplegableTipoForm(
    this.listaDesplegable,
    this.vistaList,
    this.evento,
  );
  
  late List<String> listaDesplegable = [];
  late var vistaList;
  late Evento evento;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: Alignment.center,
      icon: Icon(Icons.keyboard_double_arrow_down_outlined,color: Colors.black),
      items: listaDesplegable.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>( 
          alignment: Alignment.center,
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 20,color: Colors.black,),
          ), 
        ); 
      }).toList(),
    
      onChanged: (value) => {
        vistaList = value,
        setState(() {
          for(int i = 0; i<listaDesplegable.length;i++){
            if(value == listaDesplegable[i]){
              evento.tipo = i + 1;
            }
          }
        }),
        },
      value: vistaList,
    );
  }
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
            style: const TextStyle(fontSize: 18,color: Colors.white,),
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

