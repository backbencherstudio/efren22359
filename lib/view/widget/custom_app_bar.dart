import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/constant/app_icons.dart';

import '../../cors/routes/routes_name.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AppIcons.icon, width: 54.h, color: AppColors.primaryColor,),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RouteName.notificationScreen),
              child: Image.asset(
                "assets/icons/notification.png",
                height: 30.h,
                width: 30.w,
              ),
            ),
            //SizedBox(width: 8.w),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
