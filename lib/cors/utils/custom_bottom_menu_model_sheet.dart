import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/widget/primary_outline_button.dart';
import '../constant/app_colors.dart';

class CustomBottomMenuModelSheet {
  static void showMenuBottomSheet({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(),
              SizedBox(height: 10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: PrimaryOutlineButton(
                  text: title,
                  onPressed: () {
                    Navigator.pop(context);
                    onTap();
                  },
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
