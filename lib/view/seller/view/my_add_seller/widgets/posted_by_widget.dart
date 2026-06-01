import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/api_end_point.dart';

import '../../../../../cors/constant/app_colors.dart';

class PostedByWidget extends StatelessWidget {
  final String imageUrl;

  final String userName;

  const PostedByWidget({
    Key? key,
    this.imageUrl =
        "https://picsum.photos/seed/person_avatar/200/200", // Dynamic dummy image
    this.userName = "Savannah Nguyen",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // "Posted by" title
          Text(
            "Posted by",
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  //     await
                },
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundImage: NetworkImage(
                    "${ApiEndpoints.imageBaseurl}/uploads/images/${imageUrl}",
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    debugPrint('Error loading image: $exception');
                  },
                  child:
                      imageUrl.isEmpty
                          ? Icon(
                            Icons.person,
                            size: 24.w,
                            color: AppColors.lightTextColor,
                          )
                          : null,
                ),
              ),
              SizedBox(width: 12.w),

              // User Name
              Text(
                userName,
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
