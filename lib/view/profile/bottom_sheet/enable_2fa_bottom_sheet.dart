import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cors/constant/app_colors.dart';

class Enable2FABottomSheet extends StatelessWidget {
  final VoidCallback onEmailVerify;
  final VoidCallback onNumberVerify;
  final bool ifEmailVerified; // New parameter to check if email is verified.

  const Enable2FABottomSheet({
    Key? key,
    required this.onEmailVerify,
    required this.onNumberVerify,
    required this.ifEmailVerified, // Initialize the new parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h, // Adjust height as needed for the content
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.sliderBackgroundColor,
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text(
            "Enable 2FA",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h),

          // Pass the new parameter to the verification options
          _buildVerificationOption(
            icon: Icons.mail_outline,
            label: "Email verify",
            onTap: onEmailVerify,
            isEmailVerified: ifEmailVerified, // Pass to the widget
          ),
          SizedBox(height: 12.h),

          _buildVerificationOption(
            icon: Icons.vpn_key_outlined,
            label: "Number verify",
            onTap: onNumberVerify,
            isEmailVerified: false, // This remains unaffected by the email verification status
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildVerificationOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isEmailVerified, // New parameter to determine if email is verified
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.textFieldBox,
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.darkTextColor,
                size: 28.w,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Conditional rendering based on ifEmailVerified
              Icon(
                isEmailVerified ? Icons.check : Icons.arrow_forward_ios,
                color: AppColors.lightTextColor,
                size: 18.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
