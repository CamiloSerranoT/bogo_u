import 'dart:convert';

class EventoPrueba {
    EventoPrueba({
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
    int lugar;
    String mes;
    String nombre;
    int tipo;
    int valor;
    String? imagen;
    String? id;

    factory EventoPrueba.fromJson(Map<dynamic, dynamic> json) => EventoPrueba(
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

    Map<dynamic, dynamic> toJson() => {
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

    EventoPrueba copy() => EventoPrueba(
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
