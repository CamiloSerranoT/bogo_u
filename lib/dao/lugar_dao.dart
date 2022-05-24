import 'package:bogo_u/models/models.dart';
import 'package:firebase_database/firebase_database.dart';


class LugarDAO {
  final DatabaseReference lugarRef = FirebaseDatabase.instance.reference()
    .child('lugares');

  void guardarLugar(Lugar lugar){
    lugarRef.push().set(lugar.toJson());
  }

  Query getLugar() => lugarRef;

  void eliminarLugar(String id){
    lugarRef.child(id).remove();
  }
}