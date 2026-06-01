import 'package:flutter/material.dart';

import '../../../cors/constant/api_end_point.dart';
import '../../../cors/services/api_services.dart';

class SetPasswordProvider with ChangeNotifier {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? errorMessage;

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  void validatePasswords() {
    if (newPasswordController.text != confirmPasswordController.text) {
      errorMessage = "Passwords don't match!";
    } else {
      errorMessage = null;
    }
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    newPasswordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<bool> setPassword({required String email, required String otp}) async {
    final data = {
      "email": email,
      "token": otp,
      "password": newPasswordController.text,
    };

    final response = await _apiService.post(
      ApiEndpoints.resetPassword,
      data: data,
    );

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['success']) {
          _error = response.data['message'];
          _isLoading = false;
          newPasswordController.clear();
          confirmPasswordController.clear();
          notifyListeners();
          return true;
        } else {
          _error = response.data['message'];
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      _isLoading = false;
      _error = 'Something went wrong';
      notifyListeners();
    }
    return false;
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
