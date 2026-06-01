import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:provider/provider.dart';
import '../../../../../modelview/auth/forget_pass_provider/forget_pass_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgotPasswordScreenBody();
  }
}

class _ForgotPasswordScreenBody extends StatelessWidget {
  const _ForgotPasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForgotPasswordProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120.h,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  hintStyle: TextStyle(color: Color(0xFFD2D2D5), fontWeight: FontWeight.bold),
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
                onChanged: (email) {
                  provider.onEmailChanged(email);
                },
              ),
              SizedBox(height: 400.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                    onPressed:provider.isLoading && provider.isEmailNotEmpty ? null : () async {
                      final success = await provider.forgetPassword();
                      if(success){
                        Navigator.pushNamed(context, RouteName.resetPassOtpScreen);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(provider.errorMessage ?? "Error")),
                        );
                      }
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.isEmailNotEmpty
                        ? Color(0xff5D18EB)
                        : Color(0xFF5D18EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: provider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'Get Code',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
