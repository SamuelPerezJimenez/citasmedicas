// To parse this JSON data, do
//
//     final appointmentResponse = appointmentResponseFromJson(jsonString);

import 'dart:convert';

AppointmentResponse appointmentResponseFromJson(String str) =>
    AppointmentResponse.fromJson(json.decode(str));

String appointmentResponseToJson(AppointmentResponse data) =>
    json.encode(data.toJson());

class AppointmentResponse {
  AppointmentResponse({
    required this.response,
    required this.citas,
  });

  final String response;
  final List<Cita> citas;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentResponse(
        response: json["response"],
        citas: List<Cita>.from(json["citas"].map((x) => Cita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "citas": List<dynamic>.from(citas.map((x) => x.toJson())),
      };
}

class Cita {
  Cita(
      {required this.nombre,
      required this.apellido,
      required this.telefono,
      required this.cedula,
      required this.fecha,
      required this.estado,
      required this.tipoConsulta,
      required this.apellidoDoctor,
      required this.nombreDoctor,
      this.codPaciente = 0,
      this.codDoctor = '',
      this.codEstado = 0,
      this.codTipoCita = 0});

  final String nombre;
  final String apellido;
  final String telefono;
  final int cedula;
  DateTime fecha;
  final String estado;
  final String tipoConsulta;
  final String nombreDoctor;
  final String apellidoDoctor;
  final int codPaciente;
  String codDoctor;
  int codTipoCita;
  int codEstado;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        cedula: json["cedula"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        tipoConsulta: json["tipoConsulta"],
        nombreDoctor: json["nombreDoctor"],
        apellidoDoctor: json["apellidoDoctor"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "cedula": cedula,
        "fecha": fecha.toIso8601String(),
        "estado": estado,
        "tipoConsulta": tipoConsulta,
      };
}
