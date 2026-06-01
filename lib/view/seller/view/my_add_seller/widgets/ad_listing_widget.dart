import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/seller/view/my_add_seller/widgets/favorite_post_card.dart';
import 'package:provider/provider.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../modelview/home/get_all_post_screen_provider.dart';
import '../../../view_model/my_ad_provider.dart';
import 'ad_card.dart';

class AdListingWidget extends StatelessWidget {
  const AdListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAdProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: SizedBox(
                  height: 40.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.changeSegment(0);
                          },
                          child: Column(
                            children: [
                              Text(
                                'My Ad',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      provider.selectedSegment == 0
                                          ? AppColors.primaryColor
                                          : AppColors.lightTextColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 2.h,
                                width: MediaQuery.of(context).size.width * 0.40,
                                color:
                                    provider.selectedSegment == 0
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.changeSegment(1);
                          },
                          child: Column(
                            children: [
                              Text(
                                'Favorite',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      provider.selectedSegment == 1
                                          ? AppColors.primaryColor
                                          : AppColors.lightTextColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 2.h,
                                width: MediaQuery.of(context).size.width * 0.40,
                                color:
                                    provider.selectedSegment == 1
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// tab bar row
                ),
              ),

              if (provider.selectedSegment == 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          provider.filters.map((filter) {
                            bool isSelected = provider.selectedFilter == filter;
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: GestureDetector(
                                onTap: () {
                                  provider.changeFilter(filter);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.grayBorderColor,
                                    ),
                                  ),
                                  child: Text(
                                    filter,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.lightTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),

              SizedBox(height: 16.h),

              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: double.infinity),
                child:
                    provider.selectedSegment == 0
                        ? provider.adListings.isNotEmpty
                            ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: provider.adListings.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: GestureDetector(
                                    onTap: () async {
                                      provider.setSelectedAdTitle(
                                        provider.adListings[index].title,
                                      );
                                      debugPrint(
                                        provider.adListings[index].status,
                                      );
                                      await context.read<GetAllPostScreenProvider>().getPostDetail(provider.adListings[index].id);
                                      debugPrint('Post Detail id: ${provider.adListings[index].id}');
                                      Navigator.pushNamed(
                                        context,
                                        RouteName.homeServiceDetailScreen,
                                      );
                                    },
                                    child: AdCard(
                                      ad: provider.adListings[index],
                                    ),
                                  ),
                                );
                              },
                            )
                            : Center(child: Text("No Ads Found"))
                        : provider.favoritePostList.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: provider.favoritePostList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: GestureDetector(
                                onTap: () async {
                                  await context.read<GetAllPostScreenProvider>().getPostDetail(provider.favoritePostList[index].postId);
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.homeServiceDetailScreen,
                                  );
                                },
                                child: FavoritePostCard(
                                  favoritePostModel:
                                      provider.favoritePostList[index],
                                ),
                              ),
                            );
                          },
                        )
                        : Center(child: Text("No Favorite Post")),
              ),
              SizedBox(height: 88.h),
            ],
          ),
        );
      },
    );
  }
}
