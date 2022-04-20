import 'package:flutter/material.dart';

class MainStats extends StatelessWidget {
  const MainStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MainStatItem> items = [
      const MainStatItem(
          title: 'Citas confirmadas',
          value: 20,
          iconData: Icons.check_circle_outline,
          color: Colors.green),
      MainStatItem(
        title: 'Citas programadas',
        value: 76,
        iconData: Icons.schedule,
        color: Colors.yellow.shade700,
      ),
      const MainStatItem(
        title: 'Citas pospuestas',
        value: 32,
        iconData: Icons.calendar_today_sharp,
        color: Colors.orange,
      ),
      const MainStatItem(
        title: 'Citas canceladas',
        value: 12,
        iconData: Icons.cancel_outlined,
        color: Colors.red,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) => items[index]),
      ),
    );
  }
}

class MainStatItem extends StatefulWidget {
  const MainStatItem(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData,
      this.color = Colors.blueAccent})
      : super(key: key);

  final String title;
  final int value;
  final IconData iconData;
  final Color color;

  @override
  State<MainStatItem> createState() => _MainStatItemState();
}

class _MainStatItemState extends State<MainStatItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 30,
            backgroundColor: widget.color,
            child: Icon(
              widget.iconData,
              color: Colors.white,
            )),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              widget.value.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
