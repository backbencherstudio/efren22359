import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/widget/primary_button.dart';
import 'package:local/view/widget/primary_outline_button.dart';


class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 300.h),
            Center(
              child: Image.asset('assets/images/Logo.png',width: 180,),
            ),
            SizedBox(height: 200.h),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: PrimaryOutlineButton(
                text: 'Login',
                onPressed: () {
                 Navigator.pushNamed(context, RouteName.loginScreen) ;
                },
              ),
            ),
            SizedBox(height: 20.h),
            // SignUp Button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: PrimaryButton(
                text: 'SignUp',
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.signUpScreen) ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
