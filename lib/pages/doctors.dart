import 'package:citas_medicas_app/datatables/doctors_datasource.dart';
import 'package:citas_medicas_app/widgets/buttons/custom_outlined_button.dart';
import 'package:citas_medicas_app/widgets/k_inputs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Doctors extends StatelessWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final usersDataSource = DoctorsDataSource(['samuel']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Doctores',
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 34),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: KInputs.formInputDecoration(
                          hint: '',
                          label: 'Buscar por nombre o cédula',
                          icon: Icons.search),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButtonFormField(
                      items: menuItems,
                      onChanged: (value) {},
                      decoration: KInputs.formInputDecoration(
                        hint: '',
                        label: 'Especialidad',
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomOutlinedButton(
                    onPressed: () {},
                    text: 'Nuevo Doctor',
                    isFilled: true,
                    isTextWhite: true,
                    color: const Color(0xff0D68A8),
                  ),
                )
              ],
            ),
          ),
          PaginatedDataTable(
            // sortAscending: usersProvider.ascending,
            // sortColumnIndex: usersProvider.sortColumnIndex,
            columnSpacing: 250,
            columns: [
              DataColumn(label: Text('Avatar')),
              DataColumn(
                  label: Text('Nombre'),
                  onSort: (colIndex, _) {
                    // usersProvider.sortColumnIndex = colIndex;
                    // usersProvider.sort<String>((user) => user.nombre);
                  }),
              DataColumn(
                  label: Text('Email'),
                  onSort: (colIndex, _) {
                    // usersProvider.sortColumnIndex = colIndex;
                    // usersProvider.sort<String>((user) => user.correo);
                  }),
              DataColumn(label: Text('UID')),
              DataColumn(label: Text('Acciones')),
            ],
            source: usersDataSource,
            onPageChanged: (page) {
              print('page: $page');
            },
          )
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> menuItems = [
  DropdownMenuItem(child: Text("USA"), value: "USA"),
  DropdownMenuItem(child: Text("Canada"), value: "Canada"),
  DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
  DropdownMenuItem(child: Text("England"), value: "England"),
];
