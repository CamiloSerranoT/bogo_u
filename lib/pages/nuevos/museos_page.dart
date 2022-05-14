import 'package:flutter/material.dart';

class museosPage extends StatelessWidget {
  const museosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Museos'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { 
                 Navigator.pushNamed(context, 'menu');
              },
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 53, 52, 56),
        actions: [
          
        ],
      ),
      body: Container(),
    );
  }
}