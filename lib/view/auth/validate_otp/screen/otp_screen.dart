import 'package:flutter/material.dart';
import 'package:local/view/auth/login/screen/login_screen.dart';
import 'package:provider/provider.dart';
import '../../../../modelview/auth/signup_provider/sign_up_screen_provider.dart';
import '../../set_password/set_password_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpScreenProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify Your Code',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "We've sent a code to ",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    Text(
                      provider.email,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return _buildOtpTextField(context, index, provider);
                  }),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Resend: ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '${provider.resendSeconds}s',
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          provider.resendSeconds == 0
                              ? () => provider.resendCode(context)
                              : null,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color:
                              provider.resendSeconds == 0
                                  ? Colors.deepPurple
                                  : Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 400),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        provider.isOtpComplete
                            ? () {
                              provider.verifyOtp(context).then((success) {
                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                }
                              });
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          provider.isOtpComplete
                              ? const Color(0xff5D18EB)
                              : Colors.purple[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      side: BorderSide(
                        color:
                            provider.isOtpComplete
                                ? Colors.deepPurple
                                : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            provider.isOtpComplete
                                ? Colors.white
                                : Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpTextField(
    BuildContext context,
    int index,
    SignUpScreenProvider provider,
  ) {
    return SizedBox(
      width: 70,
      height: 70,
      child: TextFormField(
        controller: provider.otpControllers[index],
        focusNode: provider.otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) => provider.onOtpChanged(value, index),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
