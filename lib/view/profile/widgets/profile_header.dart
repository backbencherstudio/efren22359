import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../cors/constant/api_end_point.dart';
import '../../../cors/routes/routes_name.dart';
import '../../../modelview/auth/login_provider/login_screen_provider.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showPersonIcon;
  final bool showSettingsIcon;
  final VoidCallback onBackButtonTap;
  final VoidCallback onPersonIconTap;
  final VoidCallback onSettingsIconTap;

  const ProfileHeader({
    Key? key,
    required this.title,
    required this.showBackButton,
    required this.showPersonIcon,
    required this.showSettingsIcon,
    required this.onBackButtonTap,
    required this.onPersonIconTap,
    required this.onSettingsIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginScreenProvider>();
    return PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            toolbarHeight: 60.h,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(onTap: onBackButtonTap, child: Icon(Icons.arrow_back_outlined, color: Colors.white, size: 24.w,)),
                  SizedBox(width: 8.w),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Image.asset('assets/images/profilePic.png', width: 40.w),
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.generalSettingsScreen);
                },
              ),
              // Settings icon
              const SizedBox(width: 8.0),
            ],
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                        offset: const Offset(0.0, 40.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90.r),
                          child: Container(
                            height: 100.w,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppColors.fieldColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              '${ApiEndpoints.imageBaseurl}/public/storage/avatar/${loginProvider.user?.avatar}',
                              height: 100.w,
                              width: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image_outlined, size: 40,);
                              },
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(110);
}
