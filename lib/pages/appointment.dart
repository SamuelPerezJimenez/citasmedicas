import 'package:citas_medicas_app/datatables/appointment_datasource.dart';
import 'package:citas_medicas_app/models/appointment_status_model.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/appointment_model.dart';
import '../models/appointment_type_model.dart';
import '../providers/web_service.dart';
import '../widgets/buttons/custom_outlined_button.dart';
import '../widgets/k_inputs.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  String query = '';
  dynamic appointmentType, appointmentStatus, appointmentDate;

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
            'Citas',
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 34),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
        child: Column(
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
                      child: DateTimePicker(
                    decoration: KInputs.formInputDecoration(
                        hint: '', label: 'Fecha', icon: Icons.calendar_month),
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    onChanged: (val) => setState(() {
                      appointmentDate = val;
                    }),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => setState(() {
                      appointmentDate = val;
                    }),
                  )),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder(
                        future: WebService().getAppointmentType(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TipoCita>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return CircularProgressIndicator();
                          }

                          return DropdownButtonFormField(
                            items: List.generate(
                                snapshot.data!.length,
                                (index) => DropdownMenuItem(
                                      child: Text(
                                          snapshot.data![index].descripcion),
                                      value: snapshot.data?[index].cod ?? 0,
                                    )),
                            onChanged: (value) {
                              setState(() {
                                appointmentType = value;
                              });
                            },
                            value: appointmentType,
                            decoration: KInputs.formInputDecoration(
                              hint: '',
                              label: 'Tipo cita',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder(
                        future: WebService().getAppointmentStatus(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<EstadoCita>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return CircularProgressIndicator();
                          }

                          return DropdownButtonFormField(
                            items: List.generate(
                                snapshot.data!.length,
                                (index) => DropdownMenuItem(
                                      child: Text(
                                          snapshot.data![index].descripcion),
                                      value: snapshot.data?[index].cod ?? 0,
                                    )),
                            onChanged: (value) {
                              setState(() {
                                appointmentStatus = value;
                              });
                            },
                            value: appointmentStatus,
                            decoration: KInputs.formInputDecoration(
                              hint: '',
                              label: 'Estado cita',
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
                        // await WebService()
                        //     .getPatients(idPaciente: query, idArs: speciality);
                      },
                      text: 'Nueva Cita',
                      isFilled: true,
                      isTextWhite: true,
                      color: const Color(0xff0D68A8),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: WebService().getAppointments(
                  idAppointment: query,
                  idAppointmentStatus: appointmentStatus ?? 0,
                  idAppointmentType: appointmentType ?? 0,
                  date: appointmentDate ?? ''),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Cita>> snapshot) {
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
                            label: const Text('Número'),
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
                        const DataColumn(label: Text('Fecha')),
                        const DataColumn(label: Text('Estado')),
                        const DataColumn(
                            label: Text(
                          'Tipo',
                          textAlign: TextAlign.center,
                        )),
                        const DataColumn(label: Text('Acciones')),
                      ],
                      source: AppointmentsDataSource(snapshot.data!
                          .where((d) =>
                              d.nombre.toLowerCase().contains(query) ||
                              d.cedula.toString().toLowerCase().contains(query))
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
      ),
    );
  }
}
