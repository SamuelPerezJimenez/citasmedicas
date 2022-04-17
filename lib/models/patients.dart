// To parse this JSON data, do
//
//     final patientsResponse = patientsResponseFromJson(jsonString);

import 'dart:convert';

PatientsResponse patientsResponseFromJson(String str) =>
    PatientsResponse.fromJson(json.decode(str));

String patientsResponseToJson(PatientsResponse data) =>
    json.encode(data.toJson());

class PatientsResponse {
  PatientsResponse({
    required this.response,
    required this.paciente,
  });

  final String response;
  final List<Paciente> paciente;

  factory PatientsResponse.fromJson(Map<String, dynamic> json) =>
      PatientsResponse(
        response: json["response"],
        paciente: List<Paciente>.from(
            json["paciente"].map((x) => Paciente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "paciente": List<dynamic>.from(paciente.map((x) => x.toJson())),
      };
}

class Paciente {
  Paciente({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.codPersona,
    required this.descripcion,
    required this.totalCitas,
    required this.ultimaCita,
  });

  final String nombre;
  final String apellido;
  final String telefono;
  final int codPersona;
  final String descripcion;
  final int totalCitas;
  final DateTime ultimaCita;

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        codPersona: json["cod_persona"],
        descripcion: json["descripcion"],
        totalCitas: json["totalCitas"],
        ultimaCita: DateTime.parse(json["ultimaCita"]),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "cod_persona": codPersona,
        "descripcion": descripcion,
        "totalCitas": totalCitas,
        "ultimaCita": ultimaCita.toIso8601String(),
      };
}
