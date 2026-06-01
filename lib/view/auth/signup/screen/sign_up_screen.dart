import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../cors/routes/routes_name.dart';
import '../../../../modelview/auth/signup_provider/sign_up_screen_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpScreenProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: 70.h,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Create Your Account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.selectAccountType('seller');
                      },
                      child: Container(
                        height: 55.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(
                            color:
                                provider.selectedAccountType == 'seller'
                                    ? const Color(0xFF5E17EB)
                                    : Colors.grey[300]!,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'seller',
                            style: TextStyle(
                              color:
                                  provider.selectedAccountType == 'seller'
                                      ? const Color(0xFF5E17EB)
                                      : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.selectAccountType('buyer');
                      },
                      child: Container(
                        height: 55.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(
                            color:
                                provider.selectedAccountType == 'buyer'
                                    ? const Color(0xFF5E17EB)
                                    : Colors.grey[300]!,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'buyer',
                            style: TextStyle(
                              color:
                                  provider.selectedAccountType == 'buyer'
                                      ? const Color(0xFF5E17EB)
                                      : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildInputField(
              context: context,
              label: 'First Name',
              hint: 'Enter your first name',
              controller: provider.firstNameController,
              isPassword: false,
            ),
            SizedBox(height: 20.h),
            _buildInputField(
              context: context,
              label: 'Last Name',
              hint: 'Enter your last name',
              controller: provider.lastNameController,
              isPassword: false,
            ),
            SizedBox(height: 20.h),
            _buildInputField(
              context: context,
              label: 'Your Email',
              hint: 'Enter your email',
              controller: provider.emailController,
              inputType: TextInputType.emailAddress,
              isPassword: false,
            ),
            SizedBox(height: 20.h),
            _buildInputField(
              context: context,
              label: 'Password',
              hint: 'Enter your password',
              controller: provider.passwordController,
              isPassword: true,
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () async {
                  await provider.signup(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E17EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child:
                    provider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    letterSpacing: 0,
                    color: const Color(0xFF1D1F2C),
                    fontSize: 14.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.loginScreen);
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      letterSpacing: 0,
                      color: const Color(0xFF5E17EB),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    final provider = Provider.of<SignUpScreenProvider>(context);
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !provider.isPasswordVisible : false,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Color(0xFFD2D2D5)),
        hintStyle: const TextStyle(color: Color(0xFFD2D2D5)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFDFE1E7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF5E17EB)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    provider.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFFD2D2D5),
                  ),
                  onPressed: provider.togglePasswordVisibility,
                )
                : null,
      ),
    );
  }
}
