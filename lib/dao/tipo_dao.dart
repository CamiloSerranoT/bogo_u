import 'package:bogo_u/models/models.dart';
import 'package:firebase_database/firebase_database.dart';


class TipoDAO {
  final DatabaseReference tipoRef = FirebaseDatabase.instance.reference()
    .child('tipos');

  void guardarTipo(Tipo tipo){
    tipoRef.push().set(tipo.toJson());
  }

  Query getTipo() => tipoRef;

  void eliminarTipo(String id){
    tipoRef.child(id).remove();
  }

  void modificarTodoTipo(String id,Tipo tipo){
    tipoRef.child(id).set(tipo.toJson());
  }
}