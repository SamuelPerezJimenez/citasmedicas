// To parse this JSON data, do
//
//     final appointmentStatusResponse = appointmentStatusResponseFromJson(jsonString);

import 'dart:convert';

AppointmentStatusResponse appointmentStatusResponseFromJson(String str) =>
    AppointmentStatusResponse.fromJson(json.decode(str));

String appointmentStatusResponseToJson(AppointmentStatusResponse data) =>
    json.encode(data.toJson());

class AppointmentStatusResponse {
  AppointmentStatusResponse({
    required this.response,
    required this.estadoCita,
  });

  final String response;
  final List<EstadoCita> estadoCita;

  factory AppointmentStatusResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentStatusResponse(
        response: json["response"],
        estadoCita: List<EstadoCita>.from(
            json["estadoCita"].map((x) => EstadoCita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "estadoCita": List<dynamic>.from(estadoCita.map((x) => x.toJson())),
      };
}

class EstadoCita {
  EstadoCita({
    required this.cod,
    required this.descripcion,
  });

  final int cod;
  final String descripcion;

  factory EstadoCita.fromJson(Map<String, dynamic> json) => EstadoCita(
        cod: json["cod"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "descripcion": descripcion,
      };
}
