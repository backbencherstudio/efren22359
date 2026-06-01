import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';
import '../../../../../cors/constant/app_icons.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 40.h,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                  hintText: 'Search',
                  prefixIcon: Image.asset(AppIcons.searchIcon, scale: 2.0),
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
            GestureDetector(
              onTap: () {

              },
              child: Image.asset(AppIcons.filterIcon, scale: 2.2),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
