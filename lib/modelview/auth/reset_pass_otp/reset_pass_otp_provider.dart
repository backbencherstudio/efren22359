
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../cors/constant/api_end_point.dart';
import '../../../cors/services/api_services.dart';

class ResetPassOtpProvider extends ChangeNotifier {

  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());
  int resendSeconds = 30;
  Timer? _timer;

  void startResendTimer() {
    resendSeconds = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds > 0) {
        resendSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  bool get isOtpComplete => otpControllers.every((controller) => controller.text.length == 1);

  // Future<void> resendCode(BuildContext context, String email) async {
  //   if (resendSeconds > 0) return;
  //
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final url = Uri.parse(ApiEndpoints.emailVerification);
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'email': email}),
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('OTP resent successfully')),
  //       );
  //       startResendTimer();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: ${response.body}')),
  //       );
  //     }
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $error')),
  //     );
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  void onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
    notifyListeners();
  }

  String get otp => otpControllers.map((c) => c.text).join();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Future<bool> verifyOtp(BuildContext context, String email) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final url = Uri.parse(ApiEndpoints.emailVerification);
  //     final otp = otpControllers.map((c) => c.text).join();
  //     debugPrint("The otp is $otp");
  //     debugPrint("The email is $email");
  //
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'email': email, 'token': otp}),
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return true;
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: ${response.body}')),
  //       );
  //       return false;
  //     }
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $error')),
  //     );
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

}