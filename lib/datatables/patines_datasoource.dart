import 'package:citas_medicas_app/models/patients.dart';
import 'package:citas_medicas_app/pages/patients.dart';
import 'package:flutter/material.dart';

import '../models/doctors.dart';

class PatientsDataSource extends DataTableSource {
  final List<Paciente> patients;

  PatientsDataSource(this.patients);

  @override
  DataRow getRow(int index) {
    final Paciente paciente = patients[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell((Text(paciente.nombre + ' ' + paciente.apellido))),
      DataCell(Text(paciente.telefono)),
      DataCell(Text(paciente.codPersona.toString())),
      DataCell(Text(paciente.descripcion)),
      DataCell(Text(paciente.totalCitas.toString())),
      // DataCell(Text(paciente.ultimaCita.toString())),
      DataCell(IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            // NavigationService.replaceTo('/dashboard/users/${user.uid}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => patients.length;

  @override
  int get selectedRowCount => 0;
}
