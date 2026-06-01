import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';

class DeadlineContactInfoWidget extends StatelessWidget {

  final String deadline;
  final String phoneNumber;
  final String emailAddress;


  const DeadlineContactInfoWidget({
    Key? key,
    this.deadline = "Jun 29, 2025",
    this.phoneNumber = "+99125 456 789",
    this.emailAddress = "kathben@gmail.com",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Deadline Section
          Text(
            "Deadline:",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            deadline,
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp, // Scaled font size.
              fontWeight: FontWeight.w400, // Regular font weight.
            ),
          ),
          SizedBox(height: 24.h),

          // Contact Info Section (Card)
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.borderColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),

                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Contact Info:",
                  style: TextStyle(
                    color: AppColors.darkTextColor, // Dark text color for the contact info title.
                    fontSize: 20.sp, // Scaled font size.
                    fontWeight: FontWeight.w700, // Bold font weight.
                  ),
                ),
                SizedBox(height: 12.h), // Spacing below contact info title.
                Text(
                  "Call: $phoneNumber",
                  style: TextStyle(
                    color: AppColors.darkTextColor, // Dark text color for phone number.
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h), // Spacing between phone and email.
                Text(
                  "Email: $emailAddress",
                  style: TextStyle(
                    color: AppColors.darkTextColor, // Dark text color for email.
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
