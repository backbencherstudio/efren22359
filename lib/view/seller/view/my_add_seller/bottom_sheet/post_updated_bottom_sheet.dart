import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';

class PostUpdatedBottomSheet extends StatelessWidget {
  final String listingTitle;


  const PostUpdatedBottomSheet({
    Key? key,
    this.listingTitle = "At-Home Facial Treatment",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height is set to a fraction of the screen height for responsiveness.
      height: 450.h, // Adjust height as needed
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

          // "Post Updated" title
          Text(
            "Post Updated",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h), // Spacing below the title.

          // Confirmation message
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              "Your listing \"$listingTitle\" has been successfully updated.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.lightTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 32.h), // Spacing before sharing options.

          // "Share with your friends" title
          Text(
            "Share with your friends",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h), // Spacing below sharing title.

          // Social sharing icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShareOption(
                icon: Icons.facebook,
                iconColor: AppColors.facebookColor,
                label: "Facebook",
                onTap: () {
                  debugPrint("Share to Facebook");
                  // Implement Facebook sharing logic
                },
              ),
              _buildShareOption(
                icon: Icons.group, // Using a generic icon for LinkedIn as no specific LinkedIn icon in default Material Icons
                iconColor: AppColors.linkedInColor,
                label: "LinkedIn",
                onTap: () {
                  debugPrint("Share to LinkedIn");
                  // Implement LinkedIn sharing logic
                },
              ),
              _buildShareOption(
                icon: Icons.chat, // Using a generic icon for WhatsApp
                iconColor: AppColors.whatsAppColor,
                label: "WhatsApp",
                onTap: () {
                  debugPrint("Share to WhatsApp");
                  // Implement WhatsApp sharing logic
                },
              ),
              _buildShareOption(
                icon: Icons.copy,
                iconColor: AppColors.darkTextColor,
                backgroundColor: AppColors.copyLinkColor,
                label: "Copy link",
                onTap: () {
                  debugPrint("Copy link");
                  // Implement copy link logic (e.g., to clipboard)
                },
              ),
            ],
          ),
          SizedBox(height: 40.h), // Spacing before back to home button.

          // "Back to Home" button
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              // Navigate back to home or perform other actions
              debugPrint("Back to Home");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 18.w,
                  color: AppColors.lightTextColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Back to Home",
                  style: TextStyle(
                    color: AppColors.lightTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h), // Bottom padding for the sheet.
        ],
      ),
    );
  }

  /// Helper method to build individual share options (icon + label).
  Widget _buildShareOption({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
    Color? backgroundColor, // Optional background color for the icon circle
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: backgroundColor ?? iconColor, // Use provided background or iconColor
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.backgroundColor, // White icon color
              size: 30.w,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            color: AppColors.darkTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
