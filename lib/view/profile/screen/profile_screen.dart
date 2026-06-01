import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/constant/app_images.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';
import '../../../cors/constant/app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomItemAppBar(title: 'Profile'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.fieldColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 90.h,
                      width: 90.w,
                      child: Image.asset(AppImages.userProfileImage),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kath Benjamen',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(AppIcons.locationIcon, scale: 2),
                            SizedBox(width: 4.w),
                            Text(
                              'Austin, TX',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          height: 30.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Message',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
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
                        tabs: const [Tab(text: 'Posts'), Tab(text: 'Bio')],
                      ),
                      SizedBox(height: 16.0.h),
                      Expanded(
                        child: TabBarView(
                          children: [
                            //_buildAllPosts(),
                            _buildUserBio(),
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

  // Widget _buildAllPosts() {
  //   return Expanded(
  //     child: ListView.separated(
  //       shrinkWrap: true,
  //       itemCount: 10,
  //       itemBuilder: (context, index) {
  //         return CustomPostCard();
  //       },
  //       separatorBuilder: (context, index) => SizedBox(height: 8.h),
  //     ),
  //   );
  // }

  Widget _buildUserBio() {
    final List<String> experienceTags = [
      'Photoshop',
      'Figma',
      'Illustrator',
      'UI/UX Design',
      'Canva',
    ];
    return Column(
      children: [
        _buildSectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bio',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.w),
              Text(
                'I am a graphic designer based in Austin, TX, specializing in logo creation and branding. I love creating innovative designs that truly represent a business’s identity.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.lightTextColor,
                ),
              ),
            ],
          ),
        ),
        _buildSectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Experience',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.w),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children:
                    experienceTags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        backgroundColor: AppColors.fieldColor,
                        labelStyle: TextStyle(color: AppColors.lightTextColor),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
        _buildSectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Info:\n',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
              _buildRichText('Call: ', '+99125 456 789'),
              SizedBox(height: 4.h),
              _buildRichText("Email: ", 'kathben@gmail.com'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      child: child,
    );
  }

  RichText _buildRichText(title, value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: AppColors.lightTextColor, fontSize: 16),
        children: [
          TextSpan(text: title),
          TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
