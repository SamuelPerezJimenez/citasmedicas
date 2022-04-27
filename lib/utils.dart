import 'package:date_utils/date_utils.dart' as DateUtils;
import 'package:flutter/material.dart';

import 'models/disponibilidad_model.dart';

class Utils {
  DisponibilidadResponse getJustAvailables(DisponibilidadResponse result) {
    for (var d in result.disponibilidades) {
      for (var c in result.citas) {
        for (var e in d.disponibilidades!.entries) {
          if (DateUtils.DateUtils.isSameDay(e.key, c.fecha)) {
            List<DateTime>? tempHoras = d.disponibilidades![e.key]!.toList();
            tempHoras.removeWhere((element) =>
                element.hour == c.fecha.hour &&
                element.minute == c.fecha.minute);

            d.disponibilidades?[e.key] = tempHoras.toList();
          }
        }
      }
    }
    return result;
  }

  //create method with dialog with the message
  void showDialogMessage(
      BuildContext context, String message, String title) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
