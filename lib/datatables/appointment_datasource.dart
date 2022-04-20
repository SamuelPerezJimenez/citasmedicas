import 'package:citas_medicas_app/models/appointment_model.dart';
import 'package:flutter/material.dart';

class AppointmentsDataSource extends DataTableSource {
  final List<Cita> appointments;

  AppointmentsDataSource(this.appointments);

  @override
  DataRow getRow(int index) {
    final Cita appointment = appointments[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell((Text(appointment.nombre + ' ' + appointment.apellido))),
      DataCell(Text(appointment.telefono)),
      DataCell(Text(appointment.cedula.toString())),
      DataCell(Text(appointment.fecha.toString())),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
            color: const Color(0xffDFFFEC),
            borderRadius: BorderRadius.circular(10)),
        child: Text(appointment.estado),
      )),
      DataCell(Center(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
            color: const Color(0xffC1E6FF),
            borderRadius: BorderRadius.circular(10)),
        child: Text(appointment.tipoConsulta),
      ))),
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
  int get rowCount => appointments.length;

  @override
  int get selectedRowCount => 0;
}
