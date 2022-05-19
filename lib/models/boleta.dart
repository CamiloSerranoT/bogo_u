import 'dart:convert';

Map<String, Boleta> boletaFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Boleta>(k, Boleta.fromJson(v)));

String boletaToJson(Map<String, Boleta> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Boleta {
    Boleta({
      required this.idevento,
      required this.idusuario,
      this.id,
    });

    String idevento;
    String idusuario;
    String? id;

    factory Boleta.fromJson(Map<String, dynamic> json) => Boleta(
        idevento: json["idevento"],
        idusuario: json["idusuario"],
    );

    Map<String, dynamic> toJson() => {
        "idevento": idevento,
        "idusuario": idusuario,
    };

    Boleta copy() => Boleta(
      idevento: this.idevento,
      idusuario: this.idusuario,
      id: this.id,
    );
}
