import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/api_end_point.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../cors/constant/app_icons.dart';
import '../../../model/ad/ad_model.dart';
import '../../../model/favorite/favorite_post_model.dart';
import '../bottom_sheet/remove_cancel_bottom_sheet.dart';

class FavoritePostCard extends StatelessWidget {
  final FavoritePostModel favoritePostModel;

  const FavoritePostCard({super.key, required this.favoritePostModel});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              "${ApiEndpoints.imageBaseurl}/public/storage${favoritePostModel.thumbnail}",
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                width: 100.w,
                height: 100.h,
                color: AppColors.textField,
                child: Icon(
                  Icons.image,
                  size: 40.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45.r),
                        color: AppColors.fieldColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        child: Text(
                          favoritePostModel.categoryTitle,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  favoritePostModel.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkTextColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Image.asset(AppIcons.locationIcon, scale: 2),
                    SizedBox(width: 4.w),
                    Text(
                      favoritePostModel.location,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  favoritePostModel.price != null ? '\$${favoritePostModel.price}' : '\$2000',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return RemoveCancelBottomSheet(
          onRemove: () {},
          onCancel: () {},
        );
      },
    );
  }
}