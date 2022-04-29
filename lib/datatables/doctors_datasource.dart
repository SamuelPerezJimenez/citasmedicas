import 'package:flutter/material.dart';

import '../models/doctors.dart';

class DoctorsDataSource extends DataTableSource {
  final List<Doctor> doctors;

  DoctorsDataSource(this.doctors);

  @override
  DataRow getRow(int index) {
    final Doctor doctor = doctors[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell((Text(doctor.nombre + ' ' + doctor.apellido))),
      DataCell(Text(doctor.telefono)),
      DataCell(Text(doctor.codPersona.toString())),
      DataCell(Text(doctor.descripcion)),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
            color: const Color(0xffDFFFEC),
            borderRadius: BorderRadius.circular(10)),
        child: Text(doctor.ubicacionConsultorio),
      )),
      // DataCell(Center(
      //     child: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      //   decoration: BoxDecoration(
      //       color: const Color(0xffC1E6FF),
      //       borderRadius: BorderRadius.circular(10)),
      //   child: const Text('Ver disponibilidad'),
      // ))),
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
  int get rowCount => doctors.length;

  @override
  int get selectedRowCount => 0;
}
