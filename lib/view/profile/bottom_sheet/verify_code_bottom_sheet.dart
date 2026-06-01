import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../cors/constant/app_colors.dart';

class VerifyCodeBottomSheet extends StatefulWidget {
  /// Callback function to be executed when the "Next" button is tapped,
  /// providing the entered verification code.
  final ValueChanged<String> onVerify;

  /// Callback function to be executed when the "Resend" button is tapped.
  final VoidCallback onResend;

  /// Creates a [VerifyCodeBottomSheet].
  const VerifyCodeBottomSheet({
    Key? key,
    required this.onVerify,
    required this.onResend,
  }) : super(key: key);

  @override
  State<VerifyCodeBottomSheet> createState() => _VerifyCodeBottomSheetState();
}

class _VerifyCodeBottomSheetState extends State<VerifyCodeBottomSheet> {
  final TextEditingController _pinCodeController = TextEditingController();
  late Timer _timer;
  int _resendSeconds = 59; // Initial resend time from screenshot

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _pinCodeController.dispose();
    _timer.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  /// Starts the resend timer.
  void _startResendTimer() {
    _resendSeconds = 59; // Reset timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _resendSeconds--;
        });
      }
    });
  }

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
          SizedBox(height: 16.h), // Spacing below the handle.

          // "Verify Code" title
          Text(
            "Verify Code",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h), // Spacing below the title.

          // Pin Code Input Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: PinCodeTextField(
              appContext: context,
              controller: _pinCodeController,
              length: 4, // 4 digits as per screenshot
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8.r),
                fieldHeight: 60.h, // Responsive height for each field
                fieldWidth: 60.w, // Responsive width for each field
                activeFillColor: AppColors.fieldColor, // Background color when active
                inactiveFillColor: AppColors.fieldColor, // Background color when inactive
                selectedFillColor: AppColors.fieldColor, // Background color when selected
                activeColor: AppColors.primaryColor, // Border color when active
                inactiveColor: AppColors.textFieldBox, // Border color when inactive
                selectedColor: AppColors.primaryColor, // Border color when selected
              ),
              cursorColor: AppColors.primaryColor,
              animationDuration: const Duration(milliseconds: 300),
              textStyle: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              enableActiveFill: true, // Fill the background of the fields
              keyboardType: TextInputType.number,
              onChanged: (value) {
                debugPrint(value);
              },
              // Optional: autoFocus to true if you want the keyboard to pop up immediately
              // autoFocus: true,
            ),
          ),
          SizedBox(height: 16.h), // Spacing below pin code fields.

          // Resend Timer
          Align(
            alignment: Alignment.centerLeft, // Align to left as in screenshot
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text.rich(
                TextSpan(
                  text: "Resend: ",
                  style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "${_resendSeconds}s",
                      style: TextStyle(
                        color: AppColors.primaryColor, // Primary color for the timer
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h), // Spacing below resend timer.

          // Next Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onVerify(_pinCodeController.text);
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
