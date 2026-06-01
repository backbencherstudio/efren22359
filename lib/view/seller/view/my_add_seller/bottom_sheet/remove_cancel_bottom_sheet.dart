import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';

class RemoveCancelBottomSheet extends StatelessWidget {
  final VoidCallback onRemove;

  final VoidCallback onCancel;

  const RemoveCancelBottomSheet({
    Key? key,
    required this.onRemove,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height is set to a fraction of the screen height for responsiveness.
      height: 250.h, // Adjust height as needed for the two buttons
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
          SizedBox(height: 16.h), // Spacing below the handle.

          // Remove Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: SizedBox(
              width: double.infinity, // Button takes full width.
              child: ElevatedButton(
                onPressed: onRemove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.removeButtonColor, // Red background for remove.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r), // Rounded button corners.
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h), // Vertical padding.
                ),
                child: Text(
                  "Remove",
                  style: TextStyle(
                    color: AppColors.backgroundColor, // White text.
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Cancel Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: SizedBox(
              width: double.infinity, // Button takes full width.
              child: ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor, // White background.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r), // Rounded button corners.
                    side: BorderSide(color: AppColors.textFieldBox, width: 1.w), // Grey border
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h), // Vertical padding.
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
