import 'dart:convert';

Map<String, Lugar> lugarFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Lugar>(k, Lugar.fromJson(v)));

String lugarToJson(Map<String, Lugar> data) => json.encode(Map.from(data).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())));

class Lugar {
    Lugar({
      required this.direccion,
      required this.lugar,
      required this.nombre,
        this.id,
    });

    String direccion;
    int lugar;
    String nombre;
    String? id;

    factory Lugar.fromJson(Map<dynamic, dynamic> json) => Lugar(
        direccion: json["direccion"],
        lugar: json["lugar"],
        nombre: json["nombre"],
    );

    Map<dynamic, dynamic> toJson() => {
        "direccion": direccion,
        "lugar": lugar,
        "nombre": nombre,
    };
}
