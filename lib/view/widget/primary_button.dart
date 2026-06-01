import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Widget? child;

  const PrimaryButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          backgroundColor: backgroundColor ?? Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onPressed,
        child:
            child ??
            Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16.sp,
              ),
            ),
      ),
    );
  }
}
