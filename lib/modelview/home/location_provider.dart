import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleCheckbox(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}
