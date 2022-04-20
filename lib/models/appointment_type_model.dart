// To parse this JSON data, do
//
//     final appointmentTypeResponse = appointmentTypeResponseFromJson(jsonString);

import 'dart:convert';

AppointmentTypeResponse appointmentTypeResponseFromJson(String str) =>
    AppointmentTypeResponse.fromJson(json.decode(str));

String appointmentTypeResponseToJson(AppointmentTypeResponse data) =>
    json.encode(data.toJson());

class AppointmentTypeResponse {
  AppointmentTypeResponse({
    required this.response,
    required this.tipoCita,
  });

  final String response;
  final List<TipoCita> tipoCita;

  factory AppointmentTypeResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentTypeResponse(
        response: json["response"],
        tipoCita: List<TipoCita>.from(
            json["tipoCita"].map((x) => TipoCita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "tipoCita": List<dynamic>.from(tipoCita.map((x) => x.toJson())),
      };
}

class TipoCita {
  TipoCita({
    required this.cod,
    required this.descripcion,
  });

  final int cod;
  final String descripcion;

  factory TipoCita.fromJson(Map<String, dynamic> json) => TipoCita(
        cod: json["cod"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "descripcion": descripcion,
      };
}
