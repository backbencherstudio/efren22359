import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../cors/constant/api_end_point.dart';
import '../../../cors/routes/routes_name.dart';

class SignUpScreenProvider extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _deviceToken = '';
  String get deviceToken => _deviceToken;

  SignUpScreenProvider() {
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      await _firebaseMessaging.requestPermission();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Received message: ${message.notification?.title}, ${message.notification?.body}');
      });
      String? token = await _firebaseMessaging.getToken();

      if (token != null) {
        _deviceToken = token;
        debugPrint("Device Token: $_deviceToken");
        notifyListeners();
      } else {
        debugPrint("Failed to get device token: Token is null");
      }
    } catch (error) {
      debugPrint("Error getting device token: $error");
    }
  }

  bool isPasswordVisible = false;
  String selectedAccountType = 'seller';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void selectAccountType(String type) {
    selectedAccountType = type;
    notifyListeners();
  }

  bool isLoading = false;
  bool get loading => isLoading;

  Future<void> signup(BuildContext context) async {
    if (_deviceToken.isEmpty) {
      await getDeviceToken();
      if (_deviceToken.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Unable to retrieve device token')),
        );
        return;
      }
    }

    isLoading = true;
    notifyListeners();

    debugPrint("The device token is $_deviceToken");
    debugPrint(
        "The fname is ${firstNameController.text} and lname is ${lastNameController.text} "
            "and email is ${emailController.text} and password is ${passwordController.text} "
            "and type is $selectedAccountType and token is $_deviceToken");

    final url = Uri.parse(ApiEndpoints.register);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'type': selectedAccountType,
          'device_token': _deviceToken,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setEmail(emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP sent to your email successfully')),
        );
        Navigator.pushNamed(context, RouteName.otpScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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

  void onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
    notifyListeners();
  }

  Future<void> resendCode(BuildContext context) async {
    if (resendSeconds > 0) return;

    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiEndpoints.emailVerification);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': _email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP resent successfully')),
        );
        startResendTimer();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> verifyOtp(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiEndpoints.emailVerification);
      final otp = otpControllers.map((c) => c.text).join();
      debugPrint("The otp is $otp");
      debugPrint("The email is $_email");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': _email, 'token': otp}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful')),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
        return false;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}