import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/model/home/parent_category_model.dart';
import 'package:provider/provider.dart';
import '../../../modelview/home/category_provider.dart';
import '../../../modelview/home/home_category_provider.dart';

class CustomCategoryCard extends StatelessWidget {
  final ParentCategoryModel parentCategoryModel;

  const CustomCategoryCard({super.key, required this.parentCategoryModel});

  @override
  Widget build(BuildContext context) {
    final homeCategoryProvider = Provider.of<HomeCategoryProvider>(context);
    return GestureDetector(
      onTap: () {

        debugPrint("The selected category is \n\n${parentCategoryModel.title}");
        debugPrint("The selected category Id is \n\n${parentCategoryModel.id}");
        homeCategoryProvider.getSubCategory(parentCategoryModel.id!);
      },
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                homeCategoryProvider.selectedCategory ==
                        parentCategoryModel.title
                    ? AppColors.primaryColor
                    : Colors.grey.shade100,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/for_sale.png', scale: 1.5),
            ),
            Text(parentCategoryModel.title ?? ""),
          ],
        ),
      ),
    );
  }
}
