import 'package:flutter/material.dart';

class DoctorsDataSource extends DataTableSource {
  final List<String> dosctors;

  DoctorsDataSource(this.dosctors);

  @override
  DataRow getRow(int index) {
    final String user = dosctors[index];

    final image =
        Image(image: AssetImage('no-image.jpg'), width: 35, height: 35);

    return DataRow.byIndex(index: index, cells: [
      DataCell(ClipOval(child: Text('image'))),
      DataCell(Text('user.nombre')),
      DataCell(Text('user.correo')),
      DataCell(Text('user.uid')),
      DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            // NavigationService.replaceTo('/dashboard/users/${user.uid}');
          })),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dosctors.length;

  @override
  int get selectedRowCount => 0;
}
