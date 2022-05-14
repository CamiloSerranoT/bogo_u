import 'package:flutter/material.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/models/models.dart';

void main() => runApp(AppState());
 
class AppState extends StatelessWidget {
  const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService(),),
        ChangeNotifierProvider(create: ( _ ) => EventoService(),),
        //ChangeNotifierProvider(create: ( _ ) => LugarService(),),
        ChangeNotifierProvider(create: ( _ ) => LoginFormProvider(),),
      ],
      child: MyApp(),
    );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Bogo_U',
        debugShowCheckedModeBanner: false,
        initialRoute: 'checking',
        routes: {
          'login': ( _ ) => LoginPage(),
          'principal': ( _ ) => principalPage(),
          'checking' : ( _ ) => CheckAuthPage(),
          'register' : ( _ ) => RegisterPage(),
          'evento' : ( _ ) => EventoPage(),
          'boletas' : ( _ ) => boletasPage(),
          'configuraciones' : ( _ ) => configuracionesPage(),
          'configuracionesact' : ( _ ) => configuracionesActPage(),
          'cambioclave' : ( _ ) => cambioClavePage(),
          'cambioclaveant' : ( _ ) => cambioClaveActPage(),

          /*'bailes' : ( _ ) => bailesPage(),
          'conciertos' : ( _ ) => conciertosPage(),
          'entradalibre' : ( _ ) => entradaLibrePage(),
          'escenarios' : ( _ ) => escenariosPage(),
          'museos' : ( _ ) => museosPage(),
          'menu' : ( _ ) => menuPage(),
          'movistar_arena' : ( _ ) => movistarArenaPage(),
          'morat' : ( _ ) => moratPage(),*/
        },
    );
  }

}
