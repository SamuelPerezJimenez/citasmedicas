import 'package:citas_medicas_app/providers/principal_provider.dart';
import 'package:citas_medicas_app/widgets/incomingAppointments.dart';
import 'package:citas_medicas_app/widgets/patientIncomingHistory.dart';
import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/web_service.dart';
import '../utils.dart';
import '../widgets/appointments_per_day.dart';
import '../widgets/buttons/custom_outlined_button.dart';
import '../widgets/main_stats.dart';
import '../widgets/appoinment_dialog.dart';
import 'package:date_utils/date_utils.dart' as dateutil;

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<PrincipalProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainStats(),
                  // Text(date.update.toString()),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Historial de citas',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <LineSeries<PatientVisit, String>>[
                              LineSeries<PatientVisit, String>(
                                  // Bind data source
                                  dataSource: <PatientVisit>[
                                    PatientVisit('Jan', 35),
                                    PatientVisit('Feb', 28),
                                    PatientVisit('Mar', 34),
                                    PatientVisit('Apr', 32),
                                    PatientVisit('May', 40),
                                    PatientVisit('Jun', 12),
                                    PatientVisit('July', 10),
                                    PatientVisit('Aug', 46),
                                    PatientVisit('Sep', 32),
                                    PatientVisit('Oct', 15),
                                    PatientVisit('Nov', 20),
                                    PatientVisit('Dec', 67)
                                  ],
                                  xValueMapper: (PatientVisit sales, _) =>
                                      sales.month,
                                  yValueMapper: (PatientVisit sales, _) =>
                                      sales.value)
                            ]),
                      ],
                    ),
                  ),
                  AppontmentsPerDay()
                ],
              ),
            ),
            IncomingAppointments()
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              _showNotificationWithSubtitle();
            },
            child: Container(
              height: 20,
              width: 20,
              color: Colors.grey.shade100,
            ),
          ),
          CustomOutlinedButton(
            onPressed: () async {
              // var result = await WebService().getDisponibilidad(id: '2');

              // var r = Utils().getJustAvailables(result);

              await AppointmentDialog()
                  .showAppoinmentDialog(context)
                  .then((value) {});
            },
            text: 'Nueva Cita',
            isFilled: true,
            isTextWhite: true,
            color: const Color(0xff0D68A8),
          ),
        ],
      ),
    );
  }

  Future<void> _showNotificationWithSubtitle() async {
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(subtitle: 'the subtitle');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(
      subtitle: 'the subtitle',
      presentBadge: true,
      presentAlert: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(macOS: macOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Informacion',
        'Hay una cita proxima, comuniquese con el paciente para confirmar',
        platformChannelSpecifics,
        payload: 'item x');
  }
}

class PatientVisit {
  PatientVisit(this.month, this.value);
  final String month;
  final int value;
}
