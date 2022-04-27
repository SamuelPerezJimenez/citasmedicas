// To parse this JSON data, do
//
//     final arsResponse = arsResponseFromJson(jsonString);

import 'dart:convert';

ArsResponse arsResponseFromJson(String str) =>
    ArsResponse.fromJson(json.decode(str));

String arsResponseToJson(ArsResponse data) => json.encode(data.toJson());

class ArsResponse {
  ArsResponse({
    required this.response,
    required this.ars,
  });

  final String response;
  final List<Ar> ars;

  factory ArsResponse.fromJson(Map<String, dynamic> json) => ArsResponse(
        response: json["response"],
        ars: List<Ar>.from(json["ars"].map((x) => Ar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "ars": List<dynamic>.from(ars.map((x) => x.toJson())),
      };
}

class Ar {
  Ar({
    required this.cod,
    required this.descripcion,
  });

  final int cod;
  final String descripcion;

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
        cod: json["cod"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "descripcion": descripcion,
      };
}
