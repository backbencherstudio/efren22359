import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/model/category/category_post_model.dart';
import 'package:provider/provider.dart';
import '../../cors/constant/api_end_point.dart';
import '../../cors/constant/app_colors.dart';
import '../../cors/constant/app_icons.dart';
import '../../cors/constant/app_images.dart';
import '../../cors/utils/custom_bottom_menu_model_sheet.dart';
import '../../cors/utils/custom_bottom_report_model_sheet.dart';
import '../../model/home/all_post_model.dart';
import '../../modelview/home/get_all_post_screen_provider.dart';

class CustomCategoryBasedPostCard extends StatelessWidget {
  final CategoryPostModel post;

  const CustomCategoryBasedPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final getAllPostScreenProvider = Provider.of<GetAllPostScreenProvider>(context,);

    return GestureDetector(
      onTap: () {
        debugPrint("THe post Id is ${post.id}");
        getAllPostScreenProvider.getPostDetail(post.id!);
        Navigator.pushNamed(context, RouteName.homeServiceDetailScreen);
      },
      child: Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade100, width: 1.5),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child:
                  post.thumbnail != null
                      ? Image.network(
                    "${ApiEndpoints.imageBaseurl}/public/storage${post.thumbnail}" ??
                        "",
                    fit: BoxFit.cover,
                  )
                      : Image.asset(AppImages.postImage, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                              post.type,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => CustomBottomMenuModelSheet.showMenuBottomSheet(
                            context: context,
                            title: 'Report',
                            onTap:
                                () =>
                                CustomBottomReportModelSheet.showReportBottomSheet(
                                  context, post.id!,
                                ),
                          ),
                          child: const Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    Text(
                      post.title ?? 'No Title',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(AppIcons.locationIcon, scale: 2),
                        SizedBox(width: 4.w),
                        Text(
                          post.location,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightTextColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      post.price != null ? '\$${post.price}' : '\$0',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
