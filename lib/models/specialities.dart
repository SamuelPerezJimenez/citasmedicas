// To parse this JSON data, do
//
//     final specialtiesResponse = specialtiesResponseFromJson(jsonString);

import 'dart:convert';

SpecialtiesResponse specialtiesResponseFromJson(String str) =>
    SpecialtiesResponse.fromJson(json.decode(str));

String specialtiesResponseToJson(SpecialtiesResponse data) =>
    json.encode(data.toJson());

class SpecialtiesResponse {
  SpecialtiesResponse({
    required this.response,
    required this.especialidad,
  });

  final String response;
  final List<Especialidad> especialidad;

  factory SpecialtiesResponse.fromJson(Map<String, dynamic> json) =>
      SpecialtiesResponse(
        response: json["response"],
        especialidad: List<Especialidad>.from(
            json["especialidad"].map((x) => Especialidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "especialidad": List<dynamic>.from(especialidad.map((x) => x.toJson())),
      };
}

class Especialidad {
  Especialidad({
    required this.cod,
    required this.descripcion,
  });

  final int cod;
  final String descripcion;

  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        cod: json["cod"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "descripcion": descripcion,
      };
}
