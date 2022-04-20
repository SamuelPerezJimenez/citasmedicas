import 'package:citas_medicas_app/datatables/doctors_datasource.dart';
import 'package:citas_medicas_app/datatables/patines_datasoource.dart';
import 'package:citas_medicas_app/providers/web_service.dart';
import 'package:citas_medicas_app/widgets/buttons/custom_outlined_button.dart';
import 'package:citas_medicas_app/widgets/k_inputs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/doctors.dart';
import '../models/patients.dart';
import '../models/specialities.dart';

class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  String query = '';
  dynamic speciality = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Pacientes',
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
                      onChanged: (text) {
                        setState(() {
                          query = text.toLowerCase();
                        });
                      },
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
                    child: FutureBuilder(
                      future: WebService().getSpecialities(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Especialidad>> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return CircularProgressIndicator();
                          // return DropdownButtonFormField(
                          //     decoration: KInputs.formInputDecoration(
                          //       hint: '',
                          //       label: 'Cargando...',
                          //     ),
                          //     items: const [
                          //       DropdownMenuItem(
                          //         child: Text(''),
                          //         value: 0,
                          //       )
                          //     ],
                          //     onChanged: (value) {});
                        }

                        return DropdownButtonFormField(
                          items: List.generate(
                              snapshot.data!.length,
                              (index) => DropdownMenuItem(
                                    child:
                                        Text(snapshot.data![index].descripcion),
                                    value: snapshot.data?[index].cod ?? 0,
                                  )),
                          onChanged: (value) {
                            setState(() {
                              speciality = value;
                            });
                          },
                          value: speciality,
                          decoration: KInputs.formInputDecoration(
                            hint: '',
                            label: 'Especialidad',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      await WebService()
                          .getPatients(idPaciente: query, idArs: speciality);
                    },
                    text: 'Nuevo Paciente',
                    isFilled: true,
                    isTextWhite: true,
                    color: const Color(0xff0D68A8),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future:
                WebService().getPatients(idPaciente: query, idArs: speciality),
            builder:
                (BuildContext context, AsyncSnapshot<List<Paciente>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return PaginatedDataTable(
                    // sortAscending: usersProvider.ascending,
                    // sortColumnIndex: usersProvider.sortColumnIndex,
                    columnSpacing: constraints.maxWidth * 0.09,
                    columns: [
                      const DataColumn(label: Text('Nombre')),
                      DataColumn(
                          label: const Text('Teléfono'),
                          onSort: (colIndex, _) {
                            // usersProvider.sortColumnIndex = colIndex;
                            // usersProvider.sort<String>((user) => user.nombre);
                          }),
                      DataColumn(
                          label: const Text('Cédula'),
                          onSort: (colIndex, _) {
                            // usersProvider.sortColumnIndex = colIndex;
                            // usersProvider.sort<String>((user) => user.correo);
                          }),
                      const DataColumn(label: Text('ARS')),
                      const DataColumn(label: Text('Total Citas')),
                      const DataColumn(
                          label: Text(
                        'Última cita',
                        textAlign: TextAlign.center,
                      )),
                      const DataColumn(label: Text('Acciones')),
                    ],
                    source: PatientsDataSource(snapshot.data!
                        .where((d) =>
                            d.nombre.toLowerCase().contains(query) ||
                            d.codPersona
                                .toString()
                                .toLowerCase()
                                .contains(query))
                        .toList()),
                    dataRowHeight: 70,
                    onPageChanged: (page) {
                      print('page: $page');
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
