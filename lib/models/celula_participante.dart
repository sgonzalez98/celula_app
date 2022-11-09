// To parse this JSON data, do
//
//     final celulaParticipante = celulaParticipanteFromJson(jsonString);

import 'dart:convert';

CelulaParticipante celulaParticipanteFromJson(String str) => CelulaParticipante.fromJson(json.decode(str));

String celulaParticipanteToJson(CelulaParticipante data) => json.encode(data.toJson());

class CelulaParticipante {
  CelulaParticipante({
    this.id,
    required this.nombre,
    required this.celulaId,
    required this.telefono,
    this.edad,
  });

  String? id;
  String nombre;
  String celulaId;
  String telefono;
  int? edad;

  factory CelulaParticipante.fromJson(Map<String, dynamic> json) => CelulaParticipante(
        id: json["id"],
        nombre: json["nombre"],
        celulaId: json["celulaId"],
        telefono: json["telefono"],
        edad: json["edad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "celulaId": celulaId,
        "telefono": telefono,
        "edad": edad,
      };

  CelulaParticipante copy() => CelulaParticipante(
        id: id,
        nombre: nombre,
        celulaId: celulaId,
        telefono: telefono,
        edad: edad,
      );
}
