import 'dart:convert';

Map<String, Evento> eventoFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Evento>(k, Evento.fromJson(v)));

String eventoToJson(Map<String, Evento> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Evento {
    Evento({
        required this.anual,
        required this.apertura,
        required this.descripcion,
        required this.dias,
        required this.estado,
        required this.inicio,
        required this.lugar,
        required this.mes,
        required this.nombre,
        required this.tipo,
        required this.valor,
          this.imagen,
          this.id,
    });

    String anual;
    String apertura;
    String descripcion;
    String dias;
    bool estado;
    String inicio;
    String lugar;
    String mes;
    String nombre;
    int tipo;
    int valor;
    String? imagen;
    String? id;

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        anual: json["anual"],
        apertura: json["apertura"],
        descripcion: json["descripcion"],
        dias: json["dias"],
        estado: json["estado"],
        inicio: json["inicio"],
        lugar: json["lugar"],
        mes: json["mes"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        valor: json["valor"],
        imagen: json["imagen"] == null ? null : json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "anual": anual,
        "apertura": apertura,
        "descripcion": descripcion,
        "dias": dias,
        "estado": estado,
        "inicio": inicio,
        "lugar": lugar,
        "mes": mes,
        "nombre": nombre,
        "tipo": tipo,
        "valor": valor,
        "imagen": imagen == null ? null : imagen,
    };

    Evento copy() => Evento(
      anual: this.anual,
      apertura: this.apertura,
      descripcion: this.descripcion,
      dias: this.dias,
      estado: this.estado,
      inicio: this.inicio,
      lugar: this.lugar,
      mes: this.mes,
      nombre: this.nombre,
      tipo: this.tipo,
      valor: this.valor,
      imagen: this.imagen,
      id: this.id,
    );
}
