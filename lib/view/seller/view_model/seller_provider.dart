import 'package:flutter/material.dart';
class SellerProvider extends ChangeNotifier {
  List<String> _selectedExperience = [];

  List<String> get selectedExperience => _selectedExperience;

  void toggleExperience(String experience) {
    if (_selectedExperience.contains(experience)) {
      _selectedExperience.remove(experience);
    } else {
      _selectedExperience.add(experience);
    }
    notifyListeners();
  }

  void removeExperience(String experience) {
    _selectedExperience.remove(experience);
    notifyListeners();
  }
}