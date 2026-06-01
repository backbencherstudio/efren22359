import 'package:flutter/material.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/modelview/auth/forget_pass_provider/forget_pass_provider.dart';
import 'package:local/modelview/auth/reset_pass_otp/reset_pass_otp_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/modelview/auth/set_password/set_password_provider.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SetPasswordProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set New Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
              SizedBox(height: 40.h),
              const Text('New Password'),
              SizedBox(height: 12.h),
              _buildInputField(
                label: '',
                hint: 'Enter new password',
                controller: provider.newPasswordController,
                isPassword: true,
                provider: provider,
                passVisible: provider.isPasswordVisible,
                isConfirmPasswordField: false,
              ),
              SizedBox(height: 20.h),
              const Text('Confirm Password'),
              SizedBox(height: 12.h),
              _buildInputField(
                label: '',
                hint: 'Enter your password',
                controller: provider.confirmPasswordController,
                isPassword: true,
                provider: provider,
                passVisible: provider.isConfirmPasswordVisible,
                isConfirmPasswordField: true,
              ),
              SizedBox(height: 40.h),
              if (provider.errorMessage != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        provider.errorMessage!,
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.red,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: () {
                        provider.clearError();
                      },
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 260.h),
              Visibility(
                visible: !provider.isLoading,
                replacement: Center(
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed:
                        provider.errorMessage == null
                            ? () async {
                              final email =
                                  context.read<ForgotPasswordProvider>().email;
                              final otp =
                                  context.read<ResetPassOtpProvider>().otp;

                              final result = await provider.setPassword(
                                email: email,
                                otp: otp,
                              );

                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password reset successfully'),
                                  ),
                                );
                                if (context.mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteName.loginScreen,
                                    (route) => false,
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(provider.errorMessage!),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          provider.errorMessage == null
                              ? const Color(0xff5D18EB)
                              : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required passVisible,
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isPassword,
    required SetPasswordProvider provider,
    required isConfirmPasswordField,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !passVisible,
      decoration: InputDecoration(
        labelText: hint,
        hintText: label,
        hintStyle: const TextStyle(color: Color(0xFFD2D2D5)),
        labelStyle: const TextStyle(color: Color(0xFFD2D2D5)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.0.h,
          horizontal: 16.0.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD2D2D5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD2D2D5)),
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    passVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed:
                      isConfirmPasswordField
                          ? provider.toggleConfirmPasswordVisibility
                          : provider.togglePasswordVisibility,
                )
                : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      onChanged: (_) {
        provider.validatePasswords();
},
    );
  }
}
