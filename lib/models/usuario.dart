import 'dart:convert';

Map<String, Usuario> usuarioFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Usuario>(k, Usuario.fromJson(v)));

String usuarioToJson(Map<String, Usuario> data) => json.encode(Map.from(data).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())));

class Usuario {
    Usuario({
      required this.apellidos,
      required this.clave,
      required this.correo,
      required this.estado,
      required this.nombres,
      required this.telefono,
      this.imagen,
      this.id,
    });

    String apellidos;
    String clave;
    String correo;
    bool estado;
    String nombres;
    int telefono;
    String? imagen;
    String? id;

    factory Usuario.fromJson(Map<dynamic, dynamic> json) => Usuario(
        apellidos: json["apellidos"],
        clave: json["clave"],
        correo: json["correo"],
        estado: json["estado"],
        imagen: json["imagen"] == null ? null : json["imagen"],
        nombres: json["nombres"],
        telefono: json["telefono"],
    );

    Map<dynamic, dynamic> toJson() => {
        "apellidos": apellidos,
        "clave": clave,
        "correo": correo,
        "estado": estado,
        "imagen": imagen == null ? null : imagen,
        "nombres": nombres,
        "telefono": telefono,
    };

    Usuario copy() => Usuario(
      apellidos: this.apellidos,
      clave: this.clave,
      correo: this.correo,
      estado: this.estado,
      nombres: this.nombres,
      telefono: this.telefono,
      imagen: this.imagen,
      id: this.id,
    );
}