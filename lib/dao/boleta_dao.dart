import 'package:bogo_u/models/models.dart';
import 'package:firebase_database/firebase_database.dart';


class BoletaDAO {
  final DatabaseReference boletaRef = FirebaseDatabase.instance.reference()
    .child('boletas');

  void guardarBoletas(Boleta boleta){
    boletaRef.push().set(boleta.toJson());
  }

  Query getBoleta() => boletaRef;

}