import 'package:date_time_picker/date_time_picker.dart';
import 'package:date_utils/date_utils.dart' as dateutil;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:textfield_search/textfield_search.dart';

import '../models/appointment_type_model.dart';
import '../models/specialities.dart';
import '../providers/web_service.dart';
import 'buttons/custom_outlined_button.dart';
import 'k_inputs.dart';

class AppointmentDialog {
  showAppoinmentDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          dynamic appointmentType;
          // TextEditingController especialityCtrl = TextEditingController();

          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: StatefulBuilder(
                  builder: ((context, setState) => Container(
                      height: MediaQuery.of(context).size.height * 0.90,
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Scaffold(
                          floatingActionButton: CustomOutlinedButton(
                            onPressed: () async {
                              // await WebService()
                              //     .getPatients(idPaciente: query, idArs: speciality);
                            },
                            text: 'CREAR',
                            isFilled: true,
                            isTextWhite: true,
                            color: const Color(0xff0D68A8),
                          ),
                          appBar: AppBar(title: Text('Nueva cita')),
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
  dynamic appointmentType;
  dynamic appointmentEspeciality = '';
  // TextEditingController especialityCtrl = TextEditingController();
  Map<DateTime, List<String>> dates = {};

  @override
  void initState() {
    dates[DateTime(2022, 04, 20)] = ['Cyclic event'];

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFieldSearch(
                  initialList: const [
                    'Item 1 40211034414',
                    'Item 2',
                    'Item 3',
                    'Item 4',
                    'Item 5'
                  ],
                  controller: TextEditingController(),
                  label: 'Paciente',
                  decoration: KInputs.formInputDecoration(
                      hint: 'Buscar por nombre ó cédula',
                      label: 'Paciente',
                      icon: Icons.search),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () async {},
                  text: 'Nuevo paciente',
                  isFilled: false,
                  isTextWhite: false,
                  short: true,
                  color: const Color(0xff0D68A8),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FutureBuilder(
                  future: WebService().getSpecialities(allValue: false),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Especialidad>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    }

                    return DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: snapshot.data!.map((e) {
                        return '${e.descripcion}';
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
          (appointmentEspeciality != '') //appointmentEspeciality != ''
              ? TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  eventLoader: (day) {
                    if (day.weekday == DateTime.monday) {
                      return [('Cyclic event')];
                    }

                    return [];
                  },
                  onDaySelected: (day, events) {
                    for (var item in dates.entries) {
                      print(day);
                      print(item.key);
                      _showAppAvaibles(context);
                    }
                  },
                )
              : Container(),
          const SizedBox(height: 20),
          Flexible(
            child: FutureBuilder(
              future: WebService().getAppointmentType(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TipoCita>> snapshot) {
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
                      //appointmentType = value;
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
        ],
      ),
    );
  }
}

_showAppAvaibles(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        dynamic appointmentType;

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: EdgeInsets.all(24.0),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Horarios disponibles',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
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
                        label: 'Buscar por nombre o cédula',
                        icon: Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return items[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

List<Widget> items = [
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
  const ListTile(
    title: Text(
      'Veronica Rodriguez  - Consulta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      'Dr. Juan de los Santos',
      style: TextStyle(fontSize: 14),
    ),
    trailing: Text('10:00 am - 10:45 am'),
  ),
];
