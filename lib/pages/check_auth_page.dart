import 'package:bogo_u/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:bogo_u/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(), //Aca esta lo que retorna el metodo
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text('No llego un token');
            if (snapshot.data == '') {
              Future.microtask(() => {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginPage(), //atributos vacios (_)
                    transitionDuration: Duration(
                      seconds: 0
                    ), //Tiempo de transicion que hara el proceso
                  )
                )
              });
            } else {
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginPage(), //atributos vacios (_)
                      transitionDuration: Duration(
                        seconds: 0
                      ) //Tiempo de transicion que hara el proceso
                    )
                  );
                },
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}
