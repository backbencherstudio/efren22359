import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:local/cors/constant/app_colors.dart';
import '../../cors/constant/app_icons.dart';

class CustomItemAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomItemAppBar({
    super.key,
    required this.title,
    this.hasSearch = false,
  });

  final String title;
  final bool hasSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 25,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        if (hasSearch)
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(AppIcons.searchIcon, scale: 2.2, color: Colors.black,),
            ),
          ),
      ],
    );
  }

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
