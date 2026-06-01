import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';

class AdRejectionWidget extends StatelessWidget {

  final String rejectionReason;

  const AdRejectionWidget({
    super.key,
    required this.rejectionReason
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.w,
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
          // Title for the rejection reason section.
          Text(
            "Ad Rejection Reason",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.rejectionBackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.rejectionBorderColor,
                width: 1.w,
              ),
            ),
            child: Text(
              rejectionReason,
              style: TextStyle(
                color: AppColors.rejectionTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
