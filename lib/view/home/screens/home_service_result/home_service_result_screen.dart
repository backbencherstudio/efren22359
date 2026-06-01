import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/home/widget/home_filter_bottom_sheet.dart';
import 'package:local/view/widget/custom_category_post_card.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';
import 'package:local/view/widget/custom_post_card.dart';
import 'package:local/view/widget/custom_search_field.dart';
import 'package:provider/provider.dart';

import '../../../../modelview/home/category_provider.dart';
import '../../../../modelview/home/get_post_by_category_provider.dart';

class HomeServiceResultScreen extends StatelessWidget {
  const HomeServiceResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getPostByCategoryProvider = context.watch<GetPostByCategoryProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomItemAppBar(title: getPostByCategoryProvider.categoryName),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Consumer<GetPostByCategoryProvider>(
            builder: (_, getPostByCategoryProvider, __) {
              if (getPostByCategoryProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (getPostByCategoryProvider.errorMessage.isNotEmpty || getPostByCategoryProvider.errorMessage != '') {
                return Center(
                  child: Text('No posts found for this category', style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp, fontWeight: FontWeight.w600),),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomSearchField(bottomSheet: HomeFilterBottomSheet()),
                  SizedBox(height: 20.h),
                  Text('${getPostByCategoryProvider.postList.length}  found'),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: getPostByCategoryProvider.postList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.homeServiceDetailScreen,
                            );
                          },
                          child: CustomCategoryBasedPostCard(post: getPostByCategoryProvider.postList[index]),
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: 8.h),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
