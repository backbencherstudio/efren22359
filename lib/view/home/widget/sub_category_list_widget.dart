import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cors/constant/app_colors.dart';
import '../../../cors/routes/routes_name.dart';
import '../../../model/home/sub_category_model.dart';
import '../../../modelview/home/get_post_by_category_provider.dart';
import '../../../modelview/home/home_category_provider.dart';
import 'package:provider/provider.dart';

class SubCategoryListWidget extends StatelessWidget {
  const SubCategoryListWidget({
    super.key,
    required this.categoryList,
    required this.category,
  });

  final List<SubCategoryModel> categoryList;
  final String category;

  bool helpAndCommunity() {
    return category == 'Help' || category == 'Community';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            helpAndCommunity() ? '' : 'All $category',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                final item = categoryList[index];
                return GestureDetector(
                  onTap: () async {
                    final getPostByCategoryProvider = Provider.of<GetPostByCategoryProvider>(context, listen: false);
                    await getPostByCategoryProvider.getPostsByCategory(item.id ?? '');
                    await getPostByCategoryProvider.setCategoryName(item.title ?? '');
                    Navigator.pushNamed(context, RouteName.homeServiceResultScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: AppColors.fieldColor,
                        width: 3,
                      ),
                    ),
                    child: Text(item.title ?? ""),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
            ),
          ),
        ],
      ),
    );
  }
}
