import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_icons.dart';

import '../../../cors/constant/app_colors.dart';

class ConfirmLogoutBottomSheet extends StatelessWidget {
  final VoidCallback onConfirmLogout;

  final VoidCallback onCancel;

  /// Creates a [ConfirmLogoutBottomSheet].
  const ConfirmLogoutBottomSheet({
    Key? key,
    required this.onConfirmLogout,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h, // Adjust height as needed for the content
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

          // Logout Icon
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.removeButtonColor.withOpacity(0.1), // Light red background
              shape: BoxShape.circle,
            ),
            child: Image.asset(
             AppIcons.logOutIcon,
              scale: 1,
            ),
          ),
          SizedBox(height: 24.h), // Spacing below the icon.

          // "Confirm Logout" title
          Text(
            "Confirm Logout",
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
              "Are you sure you want to log out?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.lightTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 40.h), // Spacing before the buttons.

          // Yes, Log Out Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirmLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.removeButtonColor, // Red color for logout button.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  "Yes, Log Out",
                  style: TextStyle(
                    color: AppColors.backgroundColor, // White text.
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h), // Spacing between buttons.

          // Cancel Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor, // White background.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(color: AppColors.textFieldBox, width: 1.w), // Grey border
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.darkTextColor, // Dark text.
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
}
