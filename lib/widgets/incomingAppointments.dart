import 'package:flutter/material.dart';

class IncomingAppointments extends StatelessWidget {
  const IncomingAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.26,
      margin: const EdgeInsets.only(left: 30),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Proximas Citas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Text(
                    'HOY',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ...items,
            // const SizedBox(height: 20),
            // const Text(
            //   'Citas Previas',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }
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
