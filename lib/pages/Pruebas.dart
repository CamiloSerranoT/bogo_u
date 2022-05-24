import 'package:flutter/material.dart';

class Prueba extends StatelessWidget {
  const Prueba({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Fecha(),
    );
  }
}

class _Fecha extends StatefulWidget{
  
  _Fecha(
    
  );
  
  @override
  _FechaFormat createState() => _FechaFormat();
}

class _FechaFormat extends State<_Fecha> {
  
  _FechaFormat(
    
  );
  
  DateTime date=DateTime(2022,12,24);


  @override
  Widget build(BuildContext context)=>Scaffold(
    
    body:Center(
      child:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Text(
            '${date.year}/${date.month}/${date.day}',
            style:TextStyle(fontSize:32),
          ),
          const SizedBox(height:16),
          ElevatedButton(
            child:Text('Select Date'),
            onPressed:() async {
              DateTime? newDate = await showDatePicker(
                context:context,
                initialDate:date,
                firstDate:DateTime(1900),
                lastDate:DateTime(2100)
              );

              if(newDate == null) return;

              setState(() => date = newDate);
            },
          ),
        ],
      ),
    ),
  );
}