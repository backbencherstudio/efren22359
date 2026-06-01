import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/modelview/home/location_provider.dart';
import 'package:local/view/home/widget/home_filter_bottom_sheet.dart';
import 'package:local/view/home/widget/sub_category_list_widget.dart';
import 'package:local/view/widget/custom_app_bar.dart';
import 'package:local/view/widget/primary_button.dart';
import 'package:provider/provider.dart';
import '../../../modelview/home/category_provider.dart';
import '../../../modelview/home/get_all_post_screen_provider.dart';
import '../../../modelview/home/home_category_provider.dart';
import '../../widget/custom_popup_drop_down.dart';
import '../../widget/custom_search_field.dart';
import '../../widget/custom_post_card.dart';
import '../widget/custom_category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getAllPostScreenProvider = Provider.of<GetAllPostScreenProvider>(
      context,
    );
    final categoryProvider = Provider.of<CategoryProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              CustomSearchField(bottomSheet: HomeFilterBottomSheet()),
              SizedBox(height: 20.h),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      // Tab Bar
                      TabBar(
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: AppColors.darkTextColor,
                        indicatorColor: AppColors.primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 1.5,
                        tabs: const [
                          Tab(text: 'All'),
                          Tab(text: 'Category'),
                          // Tab(text: 'Location'),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildAllItem(context, getAllPostScreenProvider),
                            _buildCategoryItem(context),
                             // _buildLocationItem(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllItem(
    BuildContext context,
    GetAllPostScreenProvider getAllPostScreenProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Post',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Consumer<GetAllPostScreenProvider>(
          builder: (context, getAllPostScreenProvider, child) {
            if (getAllPostScreenProvider.posts.isEmpty) {
              return const Center(child: Text('No Post Found'));
            }
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: getAllPostScreenProvider.posts.length,
                itemBuilder: (context, index) {
                  return CustomPostCard(
                    post: getAllPostScreenProvider.posts[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse by Category',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 180.h,
          child: Consumer<HomeCategoryProvider>(
            builder: (context, homeCategoryProvider, child) {
              if (homeCategoryProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                itemCount: homeCategoryProvider.parentCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return CustomCategoryCard(
                    parentCategoryModel: homeCategoryProvider.parentCategory[index],
                  );
                },
              );
            },
          ),
        ),
        Consumer<HomeCategoryProvider>(
          builder: (context, homeCategoryProvider, child) {
            return
              homeCategoryProvider.isSubCategoryLoading
                ? Center(child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    CircularProgressIndicator(),
                  ],
                ))
                : homeCategoryProvider.subCategoryList.isEmpty
                ? const SizedBox()
                : SubCategoryListWidget(
              categoryList: homeCategoryProvider.subCategoryList,
              category: "Some Category",
            );
          },
        ),
      ],
    );
  }
  //
  // Widget _buildLocationItem(context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Filter By Location',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: 14.sp,
  //             color: Colors.black87,
  //           ),
  //         ),
  //         SizedBox(height: 8.h),
  //         CustomPopupDropdown(
  //           title: 'Country',
  //           hint: 'Select',
  //           value: 'USA',
  //           items: [],
  //           onChanged: (_) {},
  //           fillColor: AppColors.fieldColor,
  //         ),
  //         SizedBox(height: 8.h),
  //         CustomPopupDropdown(
  //           title: 'State/Province',
  //           hint: 'Select',
  //           value: 'California',
  //           items: [],
  //           onChanged: (_) {},
  //           fillColor: AppColors.fieldColor,
  //         ),
  //         SizedBox(height: 8.h),
  //         Text('City'),
  //         SizedBox(height: 8.h),
  //         TextField(
  //           decoration: InputDecoration(
  //             hintText: 'e.g., New York City',
  //             filled: true,
  //             fillColor: AppColors.fieldColor,
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12.r),
  //               borderSide: BorderSide.none,
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12.r),
  //               borderSide: BorderSide.none,
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12.r),
  //               borderSide: BorderSide.none,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 8.h),
  //         Consumer<LocationProvider>(
  //           builder: (_, locationProvider, __) {
  //             return CheckboxListTile(
  //               value: locationProvider.isChecked,
  //               onChanged: (bool? value) {
  //                 locationProvider.toggleCheckbox(value!);
  //                 // Add auto-detection functionality here
  //               },
  //               title: Text(
  //                 'Auto detect my current location',
  //                 style: TextStyle(fontSize: 14.sp),
  //               ),
  //               controlAffinity: ListTileControlAffinity.leading,
  //               activeColor: AppColors.primaryColor,
  //               checkColor: Colors.white,
  //             );
  //           },
  //         ),
  //         SizedBox(height: 100.h),
  //         SizedBox(
  //           width: MediaQuery.of(context).size.width * 0.9,
  //           child: PrimaryButton(text: 'Apply Filter'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
