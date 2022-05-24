
import 'package:flutter/material.dart';
import 'package:bogo_u/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:bogo_u/services/services.dart';
import 'package:bogo_u/models/models.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => LoginFormProvider(),),
        ChangeNotifierProvider(create: ( _ ) => AuthService(),),
        ChangeNotifierProvider(create: ( _ ) => EventoService(),),
        ChangeNotifierProvider(create: ( _ ) => TipoService(),),
        ChangeNotifierProvider(create: ( _ ) => LugarService(),),
        ChangeNotifierProvider(create: ( _ ) => UsuarioService(),),
        ChangeNotifierProvider(create: ( _ ) => BoletaService(),),
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
        'crearevento': ( _ ) => CrearEventoPage(),
        'crearlugar': ( _ ) => CrearLugarPage(),
        'creartipo': ( _ ) => CrearTipoPage(),
        'crearusuario': ( _ ) => CrearUsuarioPage(),
      },
    );
  }

}
