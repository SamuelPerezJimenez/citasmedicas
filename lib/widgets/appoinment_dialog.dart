import 'package:citas_medicas_app/utils.dart';
import 'package:citas_medicas_app/widgets/patient_dialog.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:date_utils/date_utils.dart' as dateutil;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:textfield_search/textfield_search.dart';

import '../models/appointment_type_model.dart';
import '../models/disponibilidad_model.dart';
import '../models/appointment_model.dart' as Citas;
import '../models/patients.dart';
import '../models/specialities.dart';
import '../providers/web_service.dart';
import 'buttons/custom_outlined_button.dart';
import 'k_inputs.dart';

final DateFormat formatGlobal = DateFormat('dd-MM-yyyy HH:mm');

class AppointmentDialog {
  showAppoinmentDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // TextEditingController especialityCtrl = TextEditingController();

          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: StatefulBuilder(
                  builder: ((context, setState) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.80,
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Scaffold(
                          // floatingActionButton: CustomOutlinedButton(
                          //   onPressed: () async {
                          //     print(citas)
                          //     // await WebService()
                          //     //     .getPatients(idPaciente: query, idArs: speciality);
                          //   },
                          //   text: 'CREAR',
                          //   isFilled: true,
                          //   isTextWhite: true,
                          //   color: const Color(0xff0D68A8),
                          // ),
                          appBar: AppBar(title: const Text('Nueva cita')),
                          body: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: AppointmentDialogWidget()))))));
        });
  }
}

class AppointmentDialogWidget extends StatefulWidget {
  const AppointmentDialogWidget({Key? key}) : super(key: key);

  @override
  State<AppointmentDialogWidget> createState() =>
      _AppointmentDialogWidgetState();
}

class _AppointmentDialogWidgetState extends State<AppointmentDialogWidget> {
  dynamic appointmentType = 1;
  dynamic appointmentEspeciality = '';
  dynamic patient;
  // TextEditingController especialityCtrl = TextEditingController();
  Map<DateTime, String> dates = {};
  Citas.Cita citas = Citas.Cita(
      estado: '',
      tipoConsulta: '',
      cedula: 0,
      fecha: DateTime.now(),
      nombre: '',
      apellido: '',
      telefono: '',
      apellidoDoctor: '',
      nombreDoctor: '');

  @override
  void initState() {
    super.initState();
  }

  // void _updateIfDifferent() {
  //   if (especialityCtrl.text != appointmentEspeciality) {
  //     var flag = especialityCtrl.text.split(' ');
  //     if (flag.isNotEmpty && flag.length > 1) {
  //       flag.removeAt(0);
  //       flag.removeAt(0);
  //     }
  //     appointmentEspeciality = '';
  //     for (var item in flag) {
  //       appointmentEspeciality += item + ' ';
  //     }
  //     appointmentEspeciality.toString().trim();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: FutureBuilder(
                future: WebService().getPatients(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Paciente>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container();
                  }

                  return DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: snapshot.data!
                        .map((e) => '${e.codPaciente} - ${e.codPersona} - '
                            '${e.nombre} '
                            '${e.apellido}')
                        .toList(),
                    dropdownSearchDecoration: KInputs.formInputDecoration(
                        hint: '', label: 'Paciente', icon: Icons.search),
                    showSearchBox: true,
                    selectedItem: patient,
                    onChanged: (value) {
                      setState(() {
                        patient = value;
                      });
                    },
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                width: 10,
                height: 30,
                color: Colors.grey.shade100,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomOutlinedButton(
                onPressed: () async {
                  var value = await AppointmentPatient()
                      .showAppoinmentDialog(context)
                      .then((v) => {print('sss $v')});
                },
                text: 'Nuevo paciente',
                isFilled: false,
                isTextWhite: false,
                short: true,
                color: const Color(0xff0D68A8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 3,
        //       child: TextFieldSearch(
        //         initialList: const [
        //           'Item 1 40211034414',
        //           'Item 2',
        //           'Item 3',
        //           'Item 4',
        //           'Item 5'
        //         ],
        //         //TODO: AGREGAR LISTENER
        //         controller: TextEditingController(),
        //         label: 'Doctor',
        //         decoration: KInputs.formInputDecoration(
        //             hint: 'Buscar por nombre ó código',
        //             label: 'Doctor',
        //             icon: Icons.search),
        //       ),
        //     ),
        //     SizedBox(width: 16),
        //     Expanded(
        //         child: CustomOutlinedButton(
        //       onPressed: () async {},
        //       text: 'Nuevo doctor',
        //       isFilled: false,
        //       isTextWhite: false,
        //       short: true,
        //       color: const Color(0xff0D68A8),
        //     ))
        //   ],
        // ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: FutureBuilder(
                future: WebService().getSpecialities(allValue: false),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Especialidad>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator();
                  }

                  return DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: snapshot.data!.map((e) {
                      return e.cod.toString() + "-" + e.descripcion;
                    }).toList(),
                    dropdownSearchDecoration: KInputs.formInputDecoration(
                        hint: '', label: 'Especialidad', icon: Icons.search),
                    showSearchBox: true,
                    selectedItem: appointmentEspeciality,
                    onChanged: (value) {
                      setState(() {
                        appointmentEspeciality = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Flexible(
          child: FutureBuilder(
            future: WebService().getAppointmentType(),
            builder:
                (BuildContext context, AsyncSnapshot<List<TipoCita>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              return DropdownButtonFormField(
                items: List.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                          child: Text(snapshot.data![index].descripcion),
                          value: snapshot.data?[index].cod ?? 0,
                        )),
                onChanged: (value) {
                  setState(() {
                    appointmentType = value;
                  });
                },
                value: 1,
                decoration: KInputs.formInputDecoration(
                  hint: '',
                  label: 'Tipo cita',
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        (appointmentEspeciality != '') //appointmentEspeciality != ''
            ? FutureBuilder(
                future: WebService().getDisponibilidad(
                    name: appointmentEspeciality.split('-')[1]),
                builder: (BuildContext context,
                    AsyncSnapshot<DisponibilidadResponse> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        eventLoader: (day) {
                          for (var i in snapshot.data!.disponibilidades) {
                            for (var j in i.disponibilidades!.entries) {
                              if (j.key.day == day.day &&
                                  j.key.month == day.month &&
                                  j.key.year == day.year) {
                                return j.value;
                              }
                            }
                          }
                          // if (day.weekday == DateTime.monday) {
                          //   return [('Cyclic event')];
                          // }

                          return [];
                        },
                        onDaySelected: (day, events) async {
                          if (snapshot.data!.disponibilidades.isNotEmpty) {
                            for (var i in snapshot.data!.disponibilidades) {
                              for (var j in i.disponibilidades!.entries) {
                                if (dateutil.DateUtils.isSameDay(j.key, day)) {
                                  for (var d in j.value) {
                                    if (snapshot.data!.citas.any(
                                            (element) => element.fecha == d) ==
                                        false) {
                                      dates[d] = i.nombre + " " + i.apellido;
                                    }
                                  }
                                }
                              }
                            }
                            if (dates.length > 0) {
                              try {
                                citas = await _showAppAvaibles(context,
                                    appointmentEspeciality, dates, citas);
                                setState(() {});
                              } catch (e) {}
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (citas.codDoctor != '')
                        Text(
                          'Ha seleccionado una cita con ${citas.codDoctor}\n Fecha: ${formatGlobal.format(citas.fecha)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                    ],
                  );
                },
              )
            : Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 100,
                          ),
                          Text('Seleccione una especialidad')
                        ],
                      ),
                    );
                  },
                ),
              ),
        const SizedBox(height: 20),
        CustomOutlinedButton(
          onPressed: () async {
            print(appointmentType);
            print(appointmentEspeciality);
            print(citas.codDoctor);
            print(patient);
            await WebService().saveAppointment(
                fecha: citas.fecha,
                codDoctor: citas.codDoctor,
                montoConsulta: 1500,
                nota: 'NOTA',
                fechaCreacion: DateTime.now(),
                codTipoCita: appointmentType,
                codEstado: 1,
                codPaciente: patient.split(' ')[0]);

            Navigator.pop(context);

            Utils().showDialogMessage(
              context,
              'Cita agendada con ${citas.codDoctor} de fecha y hora:  ${formatGlobal.format(citas.fecha)}',
              'Cita agendada',
            );
          },
          text: 'CREAR',
          isFilled: true,
          isTextWhite: true,
          color: const Color(0xff0D68A8),
        )
      ],
    );
  }
}

_showAppAvaibles(BuildContext context, dynamic especialidad,
    Map<DateTime, String> dates, Citas.Cita cita) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        //order  map by key ascending
        var sortedDates = dates.keys.toList()..sort((a, b) => a.compareTo(b));

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.18,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Horarios disponibles - ${especialidad.split("-")[1]}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (text) {
                      // setState(() {
                      //   query = text.toLowerCase();
                      // });
                    },
                    decoration: KInputs.formInputDecoration(
                        hint: '',
                        label: 'Buscar por nombre',
                        icon: Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: ListView.builder(
                    itemCount: sortedDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DateFormat format = DateFormat('HH:mm');
                      return ListTile(
                        onTap: () {
                          cita.fecha = sortedDates[index];
                          cita.codDoctor = dates[sortedDates[index]].toString();
                          cita.codEstado = 1;
                          Navigator.pop(context, cita);
                        },
                        title: Text(
                          dates[sortedDates[index]].toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(format.format(sortedDates[index])),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
