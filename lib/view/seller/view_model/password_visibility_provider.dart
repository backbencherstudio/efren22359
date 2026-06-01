import 'package:flutter/material.dart';

class PasswordVisibilityProvider extends ChangeNotifier {
  bool _obscureTextCurrent = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  bool get obscureTextCurrent => _obscureTextCurrent;
  bool get obscureTextNew => _obscureTextNew;
  bool get obscureTextConfirm => _obscureTextConfirm;

  void toggleObscureTextCurrent() {
    _obscureTextCurrent = !_obscureTextCurrent;
    notifyListeners();
  }

  void toggleObscureTextNew() {
    _obscureTextNew = !_obscureTextNew;
    notifyListeners();
  }

  void toggleObscureTextConfirm() {
    _obscureTextConfirm = !_obscureTextConfirm;
    notifyListeners();
  }
}
