import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = Colors.blue,
      this.isFilled = false,
      this.isTextWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          side: MaterialStateProperty.all(BorderSide(color: color)),
          backgroundColor: MaterialStateProperty.all(isFilled
              ? color.withOpacity(1)
              : Colors.transparent), //0.3 opacity
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16, color: isTextWhite ? Colors.white : color),
          ),
        ));
  }
}
