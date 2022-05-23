import 'package:bogo_u/models/models.dart';
import 'package:firebase_database/firebase_database.dart';


class UsuarioDAO {
  final DatabaseReference usuarioRef = FirebaseDatabase.instance.reference()
    .child('usuarios');

  void guardarUsuario(Usuario usuario){
    usuarioRef.push().set(usuario.toJson());
  }

  Query getUsuario() => usuarioRef;

  Future<void> eliminarUsuario(Usuario usuario){
    return usuarioRef.child(usuarioRef.key).set(usuario);
  }
}