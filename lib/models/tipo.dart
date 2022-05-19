import 'dart:convert';

Map<String, Tipo> tipoFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Tipo>(k, Tipo.fromJson(v)));

String tipoToJson(Map<String, Tipo> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Tipo {
    Tipo({
      required this.estado,
      required this.nombre,
      required this.tipo,
      this.id,
    });

    bool estado;
    String nombre;
    int tipo;
    String? id;

    factory Tipo.fromJson(Map<String, dynamic> json) => Tipo(
        estado: json["estado"],
        nombre: json["nombre"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "estado": estado,
        "nombre": nombre,
        "tipo": tipo,
    };
}
