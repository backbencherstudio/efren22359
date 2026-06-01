import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cors/constant/app_colors.dart';
import '../../cors/constant/app_icons.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.bottomSheet});

  final Widget bottomSheet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                hintText: 'Search',
                prefixIcon: Image.asset(AppIcons.searchIcon, scale: 2.5),
                filled: true,
                fillColor: AppColors.fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // GestureDetector(
          //   onTap: () {
          //     showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
          //       return bottomSheet;
          //     });
          //   },
          //   child: Image.asset(AppIcons.filterIcon, scale: 2),
          // ),
        ],
      ),
    );
  }
}
