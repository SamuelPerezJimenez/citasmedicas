import 'package:citas_medicas_app/widgets/buttons/custom_outlined_button.dart';
import 'package:date_utils/date_utils.dart' as DateUtils;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'models/disponibilidad_model.dart';

class Utils {
  final DateFormat formatGlobal = DateFormat('dd-MM-yyyy HH:mm');
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

  //create dialog with two  buttons expanded

  //create dialog with two action buttons
  void showDialogTwoButtons(
      BuildContext context, String texto, String title) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Center(child: Text(message)),
                  //row with two buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOutlinedButton(
                        onPressed: () async {
                          final link = WhatsAppUnilink(
                            phoneNumber: '18206372298',
                            text:
                                "Buenas, usted tiene una cita con el Dr. ${texto}, va a asistir?.",
                          );

                          await launch('$link');
                        },
                        text: 'Whastapp',
                        isFilled: true,
                        isTextWhite: true,
                        color: Colors.green,
                      ),
                      SizedBox(width: 20),
                      CustomOutlinedButton(
                        onPressed: () async {
                          await launch("tel://18206372298");
                        },
                        text: 'Llamada directa',
                        isFilled: true,
                        isTextWhite: true,
                        color: const Color(0xff0D68A8),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   TextButton(
            //     child: const Text("Ok"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            //   TextButton(
            //     child: const Text("Cancelar"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   )
            // ],
          );
        });
  }
}
