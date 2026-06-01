import 'package:flutter/material.dart';
import '../../../cors/constant/api_end_point.dart';
import '../../../cors/services/api_services.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String _email = '';
  bool _isEmailNotEmpty = false;

  String get email => _email;
  bool get isEmailNotEmpty => _isEmailNotEmpty;

  void onEmailChanged(String value) {
    _email = value;
    _isEmailNotEmpty = _email.isNotEmpty;
    notifyListeners();
  }

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<bool> forgetPassword() async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = {
        "email": email,
      };

      debugPrint("The email is $email");

      final response = await _apiService.post(
        ApiEndpoints.forgetPassword,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        if (response.data['success']) {
          _errorMessage=response.data['message'];
          notifyListeners();
          return true;
        }
      } else {
        _errorMessage = response.data['message'];
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Something went wrong';
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}