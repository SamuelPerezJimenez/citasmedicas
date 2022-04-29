import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../models/appointment_model.dart';
import '../providers/web_service.dart';
import '../utils.dart';

class IncomingAppointments extends StatelessWidget {
  const IncomingAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.26,
      margin: const EdgeInsets.only(left: 30),
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: WebService().getAppointments(
            idAppointment: '',
            idAppointmentStatus: 0,
            idAppointmentType: 0,
            date: ''),
        builder: (BuildContext context, AsyncSnapshot<List<Cita>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Proximas Citas',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(8.0),
                    //   decoration: BoxDecoration(
                    //       color: Colors.amber,
                    //       borderRadius: BorderRadius.circular(10.0)),
                    //   child: const Text(
                    //     'HOY',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 850,
                  child: ListView(
                    controller: ScrollController(),
                    children: List.generate(
                        snapshot.data!.length,
                        (index) => Column(
                              children: [
                                ListTile(
                                  onTap: () async {
                                    Utils().showDialogTwoButtons(
                                        context,
                                        '${snapshot.data![index].nombreDoctor} ${snapshot.data![index].apellidoDoctor} a ${Utils().formatGlobal.format(snapshot.data![index].fecha)}',
                                        'Seleccione la vía para contactar');
                                  },
                                  title: Text(
                                    '${snapshot.data![index].nombre} ${snapshot.data![index].apellido} - ${snapshot.data![index].tipoConsulta}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${snapshot.data![index].nombreDoctor} ${snapshot.data![index].apellidoDoctor}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  trailing: Text(
                                      '${Utils().formatGlobal.format(snapshot.data![index].fecha)}'),
                                )
                              ],
                            )),
                  ),
                ),
                // const SizedBox(height: 20),
                // const Text(
                //   'Citas Previas',
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
