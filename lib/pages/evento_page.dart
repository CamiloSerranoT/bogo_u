import 'package:bogo_u/providers/providers.dart';
import 'package:bogo_u/services/services.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/ui/input_decorations.dart';
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
                  top: 30,
                  left: 5,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white),
                  )
                ),
                Positioned(
                  top: 30,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: (){
          // Programar guardar el producto.
        },
      ),
    );
  }
}

class _EventoForm extends StatelessWidget {
  const _EventoForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventoForm = Provider.of<EventoFormProvider>(context);
    final evento = eventoForm.evento;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextFormField(
                initialValue: evento.nombre,
                onChanged: ( value ) => evento.nombre = value,
                validator: ( value ) {
                  if(value == null || value.length < 1){
                    return 'El nombre es obligatorio';
                  }
                }, 
                decoration: InputDecorations.authInputDecoration(hintText: 'Nombre del Producto', labelText: 'Nombre'),
              ),
              SizedBox(height: 30,),
              TextFormField(
                initialValue: '${evento.valor}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+$'))
                ],
                onChanged: ( value ) {
                  if(int.tryParse(value) == null){
                    evento.valor = 0;
                  }else{
                    evento.valor = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number, // Deja solo teclado numerico 
                decoration: InputDecorations.authInputDecoration(hintText: '\$10.000', labelText: 'Valor'),
              ),
              SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible'),
                activeColor: Colors.indigo, 
                onChanged: eventoForm.updateEstado,
              )
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0,5),
        )
      ]
  );
}