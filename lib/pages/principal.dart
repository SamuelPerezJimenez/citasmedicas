import 'package:citas_medicas_app/widgets/incomingAppointments.dart';
import 'package:citas_medicas_app/widgets/patientIncomingHistory.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/appointments_per_day.dart';
import '../widgets/buttons/custom_outlined_button.dart';
import '../widgets/main_stats.dart';
import '../widgets/appoinment_dialog.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: CustomOutlinedButton(
        onPressed: () async {
          await AppointmentDialog().showAppoinmentDialog(context);
          // await WebService()
          //     .getPatients(idPaciente: query, idArs: speciality);
        },
        text: 'Nueva Cita',
        isFilled: true,
        isTextWhite: true,
        color: const Color(0xff0D68A8),
      ),
    );
  }
}

class PatientVisit {
  PatientVisit(this.month, this.value);
  final String month;
  final int value;
}
