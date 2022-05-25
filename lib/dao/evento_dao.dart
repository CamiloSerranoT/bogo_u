import 'package:bogo_u/models/evento.dart';
import 'package:firebase_database/firebase_database.dart';


class EventoDAO {
  final DatabaseReference eventoRef = FirebaseDatabase.instance.reference()
    .child('eventos');

  void guardarEvento(Evento evento){
    eventoRef.push().set(evento.toJson());
  }

  Query getEvento() => eventoRef;

  void eliminarEvento(String id){
    eventoRef.child(id).remove();
  }

  void modificarTodoEvento(String id,Evento evento){
    eventoRef.child(id).set(evento.toJson());
  }
}