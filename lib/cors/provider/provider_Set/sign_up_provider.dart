import 'package:flutter/material.dart';
class SignUpProvider extends ChangeNotifier {
  bool isPasswordVisible = false;
  String selectedAccountType = 'Sellers';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void selectAccountType(String type) {
    selectedAccountType = type;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}