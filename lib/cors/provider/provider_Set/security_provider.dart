import 'package:flutter/material.dart';

class SecurityProvider extends ChangeNotifier {
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isCurrentPasswordVisible => _isCurrentPasswordVisible;
  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void togglePasswordVisibility(String fieldName) {
    if (fieldName == 'current') {
      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
    } else if (fieldName == 'new') {
      _isNewPasswordVisible = !_isNewPasswordVisible;
    } else if (fieldName == 'confirm') {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    }
    notifyListeners();
  }
}