import 'package:flutter/cupertino.dart';

class PrincipalProvider with ChangeNotifier {
  DateTime updateG = DateTime.now();

  DateTime get update => updateG;

  set update(DateTime value) {
    updateG = value;
    notifyListeners();
  }
}
