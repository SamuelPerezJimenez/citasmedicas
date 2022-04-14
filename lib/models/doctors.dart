// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    required this.response,
    required this.doctor,
  });

  final String response;
  final List<Doctor> doctor;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        response: json["response"],
        doctor:
            List<Doctor>.from(json["doctor"].map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "doctor": List<dynamic>.from(doctor.map((x) => x.toJson())),
      };
}

class Doctor {
  Doctor({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.codPersona,
    required this.descripcion,
    required this.ubicacionConsultorio,
  });

  final String nombre;
  final String apellido;
  final String telefono;
  final int codPersona;
  final String descripcion;
  final String ubicacionConsultorio;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        codPersona: json["cod_persona"],
        descripcion: json["descripcion"],
        ubicacionConsultorio: json["ubicacion_consultorio"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "cod_persona": codPersona,
        "descripcion": descripcion,
        "ubicacion_consultorio": ubicacionConsultorio,
      };
}
