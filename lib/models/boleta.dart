import 'dart:convert';

Map<String, Boleta> boletaFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Boleta>(k, Boleta.fromJson(v)));

String boletaToJson(Map<String, Boleta> data) => json.encode(Map.from(data).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())));

class Boleta {
    Boleta({
      required this.idevento,
      required this.idusuario,
      this.id,
    });

    int idevento;
    String idusuario;
    String? id;

    factory Boleta.fromJson(Map<dynamic, dynamic> json) => Boleta(
        idevento: json["idevento"],
        idusuario: json["idusuario"],
    );

    Map<dynamic, dynamic> toJson() => {
        "idevento": idevento,
        "idusuario": idusuario,
    };
}

