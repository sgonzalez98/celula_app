class Celula {
  Celula({
    this.ministerio,
    required this.usuarioId,
    required this.lugar,
    this.dia,
    required this.hora,
    this.descripcion,
    this.id,
    this.estado,
  });

  String? ministerio;
  String usuarioId;
  String lugar;
  String? dia;
  String hora;
  String? descripcion;
  String? id;
  String? estado;

  factory Celula.fromJson(Map<String, dynamic> json) => Celula(
        ministerio: json["ministerio"],
        usuarioId: json["usuarioId"],
        lugar: json["lugar"],
        dia: json["dia"],
        hora: json["hora"],
        descripcion: json["descripcion"],
        id: json["id"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "ministerio": ministerio,
        "usuarioId": usuarioId,
        "lugar": lugar,
        "dia": dia,
        "hora": hora,
        "descripcion": descripcion,
        "id": id,
        "estado": estado,
      };

  Celula copy() => Celula(
        ministerio: ministerio,
        usuarioId: usuarioId,
        lugar: lugar,
        dia: dia,
        hora: hora,
        descripcion: descripcion,
        id: id,
        estado: estado,
      );
}
