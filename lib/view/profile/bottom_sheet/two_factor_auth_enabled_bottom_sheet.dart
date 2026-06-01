import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cors/constant/app_colors.dart';

class TwoFactorAuthEnabledBottomSheet extends StatelessWidget {
  /// Callback function to be executed when the "Done" button is tapped.
  final VoidCallback onDone;

  /// Creates a [TwoFactorAuthEnabledBottomSheet].
  const TwoFactorAuthEnabledBottomSheet({
    Key? key,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height is set to a fraction of the screen height for responsiveness.
      height: 400.h, // Adjust height as needed for the content
      decoration: BoxDecoration(
        color: AppColors.backgroundColor, // White background for the bottom sheet.
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Rounded top corners.
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Take minimum vertical space.
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.sliderBackgroundColor, // Grey color for the handle.
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            ),
          ),
          SizedBox(height: 24.h), // Spacing below the handle.

          // Success Icon (Circle with checkmark and surrounding dots)
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer dots (simulated with a few positioned circles)
              Positioned(
                top: 0.h,
                left: 60.w,
                child: _buildDot(AppColors.primaryColor.withOpacity(0.4)),
              ),
              Positioned(
                top: 10.h,
                right: 60.w,
                child: _buildDot(AppColors.primaryColor.withOpacity(0.4)),
              ),
              Positioned(
                bottom: 0.h,
                left: 80.w,
                child: _buildDot(AppColors.primaryColor.withOpacity(0.4)),
              ),
              Positioned(
                bottom: 10.h,
                right: 80.w,
                child: _buildDot(AppColors.primaryColor.withOpacity(0.4)),
              ),

              // Main circle with checkmark
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor, // Primary color for the circle
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check, // Checkmark icon
                  color: AppColors.backgroundColor, // White checkmark
                  size: 40.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h), // Spacing below the icon.

          // "Two-Factor Authentication Enabled" title
          Text(
            "Two-Factor",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Authentication Enabled",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h), // Spacing below the title.

          // Confirmation message
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              "You've successfully enabled two-factor\nauthentication for your account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.lightTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 40.h), // Spacing before the button.

          // Done Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Primary color for button.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r), // Rounded button corners.
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h), // Vertical padding.
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: AppColors.backgroundColor, // White text.
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h), // Bottom padding for the sheet.
        ],
      ),
    );
  }

  /// Helper method to build a small dot for the success icon animation.
  Widget _buildDot(Color color) {
    return Container(
      width: 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
