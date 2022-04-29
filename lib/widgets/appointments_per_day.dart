import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart' as dateutil;
import 'package:intl/intl.dart';

import '../models/appointment_model.dart';
import '../providers/web_service.dart';

class AppontmentsPerDay extends StatefulWidget {
  const AppontmentsPerDay({Key? key}) : super(key: key);

  @override
  State<AppontmentsPerDay> createState() => _AppontmentsPerDayState();
}

class _AppontmentsPerDayState extends State<AppontmentsPerDay> {
  late List<DateTime> fechas;

  @override
  void initState() {
    fechas = dateutil.DateUtils.daysInMonth(
            dateutil.DateUtils.lastDayOfMonth(DateTime.now()))
        .where((element) =>
            DateTime.now().isBefore(element) ||
            dateutil.DateUtils.isSameDay(element, DateTime.now()))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: OBTENER CANTIDAD DE CITAS POR DIAS
    return Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM').format(DateTime.now()),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: FutureBuilder(
                future: WebService().getAppointments(
                    idAppointment: '',
                    idAppointmentStatus: 0,
                    idAppointmentType: 0,
                    date: ''),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Cita>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: fechas.length,
                    itemBuilder: (BuildContext context, int index) {
                      var count = snapshot.data!
                          .where((element) => dateutil.DateUtils.isSameDay(
                              element.fecha, fechas[index]))
                          .toList()
                          .length;
                      return Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: AppointmentPerDayItem(
                            //snapshot.data![0].fecha count when date matchs

                            count: count,
                            dateTime: fechas[index],
                            selected: (dateutil.DateUtils.isSameDay(
                                fechas[index], DateTime.now()))),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class AppointmentPerDayItem extends StatelessWidget {
  const AppointmentPerDayItem({
    Key? key,
    required this.selected,
    this.count = 0,
    required this.dateTime,
  }) : super(key: key);

  final bool selected;
  final int count;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final fontColor = selected ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
          color: selected ? const Color(0xff0D68A8) : const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 40.0),
      child: Column(
        children: [
          Text(dateTime.day.toString(),
              style: TextStyle(color: fontColor, fontSize: 16)),
          Text(DateFormat('EE').format(dateTime),
              style: TextStyle(color: fontColor, fontSize: 16)),
          const SizedBox(height: 10),
          Text(
            count.toString(),
            style: TextStyle(
                color: fontColor, fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
    );
  }
}
