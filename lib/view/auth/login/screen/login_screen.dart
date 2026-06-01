import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/modelview/auth/login_provider/login_screen_provider.dart';
import 'package:local/view/auth/signup/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../../../../cors/provider/password_visibility_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Login to Your Account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              Text('E-mail', style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 10.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  hintStyle: TextStyle(color: Color(0xFFD2D2D5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Color(0xFFDFE1E7)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Color(0xFFDFE1E7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Color(0xFFDFE1E7)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              Text('Password', style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 10.h),
              Consumer<PasswordVisibilityProvider>(
                builder: (context, passwordVisibilityProvider, child) {
                  return TextFormField(
                    obscureText: passwordVisibilityProvider.isObscured,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(color: Color(0xFFD2D2D5)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Color(0xFFDFE1E7)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Color(0xFFDFE1E7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Color(0xFFDFE1E7)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibilityProvider.isObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFFD2D2D5),
                        ),
                        onPressed: () {
                          passwordVisibilityProvider.toggleVisibility();
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  );
                },
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.forgotPasswordScreen,
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF5E17EB),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: Consumer<LoginScreenProvider>(
                  builder: (context, loginScreenProvider, child) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed:
                                loginScreenProvider.isLoading
                                    ? null
                                    : () async {
                                      final success = await loginScreenProvider
                                          .login(
                                            context,
                                            emailController.text,
                                            passwordController.text,
                                          );

                                      if (success) {
                                        Navigator.pushNamed(
                                          context,
                                          RouteName.sellerParentScreen,
                                        );
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5E17EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              elevation: 0,
                            ),
                            child:
                                loginScreenProvider.isLoading
                                    ? SizedBox(
                                      height: 24.h,
                                      width: 24.h,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  'Or continue with',
                  style: TextStyle(fontSize: 16.sp, color: Color(0xFF1D1F2C)),
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          width: 40.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Google',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/fb.png',
                          width: 40.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Facebook',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      letterSpacing: 0,
                      color: Color(0xFF1D1F2C),
                      fontSize: 16.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          letterSpacing: 0,
                          color: Color(0xFF5E17EB),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
