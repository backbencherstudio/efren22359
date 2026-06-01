import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_icons.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/seller/view_model/post_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../modelview/home/category_provider.dart';

class PostSelectionScreen extends StatefulWidget {
  const PostSelectionScreen({super.key});

  @override
  State<PostSelectionScreen> createState() => _PostSelectionScreenState();
}

class _PostSelectionScreenState extends State<PostSelectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().getParentCategory();
    });
  }

  final List<String> postOptionsIcons = [
    AppIcons.serviceIcon,
    AppIcons.jobIcon,
    AppIcons.forSaleIcon,
    AppIcons.gigsIcon,
    AppIcons.helpIcon,
    AppIcons.communityIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          "Post",
          style: TextStyle(
            color: AppColors.darkTextColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              "Choose what you'd like to post:",
              style: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24.h),

            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (_, provider, __) {
                  if (provider.parentCategory.isEmpty) {
                    return const Center(child: Text('No Category Found'));
                  }
                  return ListView.separated(
                    itemCount: provider.parentCategory.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final option = provider.parentCategory[index];
                      return _buildPostOptionCard(
                        icon: postOptionsIcons[index],
                        label: option.title ?? "",
                        onTap: () {
                          Provider.of<PostViewmodel>(
                            context,
                            listen: false,
                          ).selectOption(option.title ?? "");
                          Provider.of<PostViewmodel>(
                            context,
                            listen: false,
                          ).selectOptionId(option.id ?? "");
                          Navigator.pushNamed(
                            context,
                            RouteName.servicePostScreen,
                          );
                          debugPrint(
                            "Tapped on ${option.title}, id: ${option.id}",
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostOptionCard({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.textFieldBox, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(icon, scale: 1.9),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
