import 'package:date_utils/date_utils.dart';

import 'models/disponibilidad_model.dart';

class Utils {
  getJustAvailables(DisponibilidadResponse result) {
    for (var d in result.disponibilidades) {
      for (var c in result.citas) {
        for (var e in d.disponibilidades!.entries) {
          if (DateUtils.isSameDay(e.key, c.fecha)) {
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
}
