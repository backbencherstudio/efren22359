import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryOutlineButton extends StatelessWidget {
  final String text;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Widget? child;
  const PrimaryOutlineButton({
    super.key,
    required this.text,
    this.borderColor = const Color(0xff5D18EB),
    this.textColor = Colors.black,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        side: BorderSide(width: 2, color: const Color(0xffD2D2D5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r), // Set the border radius here
        ),
      ),
      onPressed: onPressed ?? () {},
      child: child ?? Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: textColor ?? Color(0xff5D18EB),
        ),
      ),
    );
  }
}
