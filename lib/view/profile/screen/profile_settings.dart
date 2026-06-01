import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/modelview/auth/login_provider/login_screen_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_header.dart';
import '../widgets/settings_content_widget.dart';
import '../widgets/username_widget.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginScreenProvider>();
    return Scaffold(
      appBar: ProfileHeader(
        title: 'Settings',
        showPersonIcon: true,
        showSettingsIcon: false,
        onPersonIconTap: () {},
        onSettingsIconTap: () {},
        showBackButton: true,
        onBackButtonTap: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              UserName(userName: loginProvider.user?.name ?? "", userLocation: loginProvider.user?.address ?? "",),
              SizedBox(height: 16.h,),
              SettingsContentWidget(),
              SizedBox(height: 16.h,),
            ],
          ),
        ),
      ),
    );
  }
}