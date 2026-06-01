import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cors/constant/app_colors.dart';

class Enable2FAPhoneBottomSheet extends StatefulWidget {

  final ValueChanged<String> onNext;

  /// Creates an [Enable2FAPhoneBottomSheet].
  const Enable2FAPhoneBottomSheet({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  @override
  State<Enable2FAPhoneBottomSheet> createState() => _Enable2FAPhoneBottomSheetState();
}

class _Enable2FAPhoneBottomSheetState extends State<Enable2FAPhoneBottomSheet> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height is set to a fraction of the screen height for responsiveness.
      height: 350.h, // Adjust height as needed for the content
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

          // "Enable 2FA" title
          Text(
            "Enable 2FA",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h), // Spacing below the title.

          // Phone Number Input Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundColor, // White background for text field
                hintText: "Your Phone Number",
                hintStyle: TextStyle(
                  color: AppColors.lightTextColor,
                  fontSize: 16.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.textFieldBox, width: 1.w), // Grey border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.textFieldBox, width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w), // Primary color border on focus
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              style: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 24.h), // Spacing below phone number field.

          // Next Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onNext(_phoneNumberController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Primary color for button.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r), // Rounded button corners.
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h), // Vertical padding.
                ),
                child: Text(
                  "Next",
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
}
