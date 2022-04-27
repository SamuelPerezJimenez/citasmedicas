import 'package:citas_medicas_app/models/ars.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../providers/web_service.dart';
import '../utils.dart';
import 'buttons/custom_outlined_button.dart';
import 'k_inputs.dart';

class AppointmentPatient {
  showAppoinmentDialog(BuildContext context) async {
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
                          appBar: AppBar(title: const Text('Nuevo paciente')),
                          body: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: AppointmentPatientWidget()))))));
        });
  }
}

class AppointmentPatientWidget extends StatefulWidget {
  AppointmentPatientWidget({Key? key}) : super(key: key);

  @override
  State<AppointmentPatientWidget> createState() =>
      _AppointmentPatientWidgetState();
}

class _AppointmentPatientWidgetState extends State<AppointmentPatientWidget> {
  String cedula = '';
  String nombre = '';
  String apellido = '';
  String telefono = '';
  String correo = '';
  String ars = '';
  String num_afiliado = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  cedula = text;
                });
              },
              decoration: KInputs.formInputDecoration(
                  hint: '', label: 'Cédula', icon: null),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  nombre = text;
                });
              },
              decoration: KInputs.formInputDecoration(
                  hint: '', label: 'Nombre', icon: null),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  apellido = text;
                });
              },
              decoration: KInputs.formInputDecoration(
                  hint: '', label: 'Apellido', icon: null),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  telefono = text;
                });
              },
              decoration: KInputs.formInputDecoration(
                  hint: '', label: 'Telefono', icon: null),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  correo = text;
                });
              },
              decoration: KInputs.formInputDecoration(
                  hint: '', label: 'Correo', icon: null),
            ),
          ),
        ),
        Flexible(
          child: FutureBuilder(
            future: WebService().getArs(),
            builder: (BuildContext context, AsyncSnapshot<List<Ar>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: snapshot.data!
                      .map((e) => '${e.cod}-${e.descripcion}')
                      .toList(),
                  dropdownSearchDecoration: KInputs.formInputDecoration(
                      hint: '', label: 'ARS', icon: Icons.search),
                  showSearchBox: true,
                  selectedItem: ars,
                  onChanged: (value) {
                    setState(() {
                      ars = value!;
                    });
                  },
                ),
              );
            },
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  num_afiliado = text;
                });
              },
              decoration: KInputs.formInputDecoration(
                  hint: '', label: 'Num afiliado', icon: null),
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomOutlinedButton(
          onPressed: () async {
            await WebService().savePatient(
                nombre: nombre,
                apellido: apellido,
                correo: correo,
                codPersona: cedula,
                id_ars: ars.split('-')[0],
                telefono: telefono,
                num_afiliado: num_afiliado);

            Navigator.pop(context, true);

            Utils().showDialogMessage(
              context,
              '',
              'Paciente creado correctamente',
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
