// To parse this JSON data, do
//
//     final disponibilidadResponse = disponibilidadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:date_utils/date_utils.dart' as dateUtils;
import 'package:flutter/material.dart';

DisponibilidadResponse disponibilidadResponseFromJson(String str) =>
    DisponibilidadResponse.fromJson(json.decode(str));

String disponibilidadResponseToJson(DisponibilidadResponse data) =>
    json.encode(data.toJson());

class DisponibilidadResponse {
  DisponibilidadResponse({
    required this.response,
    required this.disponibilidades,
    required this.citas,
  });

  final String response;
  final List<Disponibilidade> disponibilidades;
  final List<Cita> citas;

  factory DisponibilidadResponse.fromJson(Map<String, dynamic> json) =>
      DisponibilidadResponse(
        response: json["response"],
        disponibilidades: List<Disponibilidade>.from(
            json["disponibilidades"].map((x) => Disponibilidade.fromJson(x))),
        citas: List<Cita>.from(json["citas"].map((x) => Cita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "disponibilidades":
            List<dynamic>.from(disponibilidades.map((x) => x.toJson())),
        "citas": List<dynamic>.from(citas.map((x) => x.toJson())),
      };
}

class Cita {
  Cita({
    required this.cita,
    required this.fecha,
  });

  final int cita;
  final DateTime fecha;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        cita: json["cita"],
        fecha: DateTime.parse(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "cita": cita,
        "fecha": fecha.toIso8601String(),
      };
}

class Disponibilidade {
  Disponibilidade(
      {required this.cod,
      required this.horaInicio,
      required this.horaFin,
      required this.dia,
      required this.duracioCita,
      required this.idDoctor,
      required this.nombre,
      required this.apellido,
      required this.especialidad,
      this.horas,
      this.disponibilidades});

  final int cod;
  final String horaInicio;
  final String horaFin;
  final String dia;
  final int duracioCita;
  final int idDoctor;
  final String nombre;
  final String apellido;
  final String especialidad;
  final List<DateTime>? horas;
  final Map<DateTime, List<DateTime>>? disponibilidades;

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    //Crear lista de fechas con diferencia de 30 minutos entre fecha inicio y fecha fin
    Map<DateTime, List<DateTime>> tempDisponibilidades = {};

    List<DateTime> listaDiasMes = [];
    var month = DateTime.now();
    var days = dateUtils.DateUtils.daysInMonth(month);

    days.removeWhere((d) =>
        (d.month != month.month || json["dia"] != d.weekday.toString()) ||
        (d.isBefore(month)));
    for (var element in days) {
      var horaFin = DateTime.parse(
          '${element.toString().split(' ')[0]} ${json["hora_fin"]}');
      var horaInicio = DateTime.parse(
          '${element.toString().split(' ')[0]} ${json["hora_inicio"]}');
      List<DateTime> listaHoras = [];
      for (var i = horaInicio;
          i.hour <= horaFin.hour &&
              ((i.hour == horaFin.hour) ? i.minute <= horaFin.minute : true);
          i = i.add(
              Duration(minutes: ((json["duracio_cita"] / 60).floor() ?? 30)))) {
        listaHoras.add(i);
      }
      tempDisponibilidades[element] = listaHoras;
    }

    return Disponibilidade(
        cod: json["cod"],
        horaInicio: json["hora_inicio"],
        horaFin: json["hora_fin"],
        dia: json["dia"],
        duracioCita: json["duracio_cita"],
        idDoctor: json["idDoctor"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        especialidad: json["especialidad"],
        disponibilidades: tempDisponibilidades);
  }

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "hora_inicio": horaInicio,
        "hora_fin": horaFin,
        "dia": dia,
        "duracio_cita": duracioCita,
        "idDoctor": idDoctor,
      };
}
