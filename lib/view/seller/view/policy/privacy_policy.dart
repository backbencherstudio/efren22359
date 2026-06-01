import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/view/seller/view/seller_parent/widget/seller_parent_screen_widget.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomItemAppBar(title: 'Privacy Policy'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            _buildSection('Data Collection',
                'We collect basic user information like name, email, and profile image to enhance your experience.'),
            SizedBox(height: 20.h),
            _buildSection('Data Usage',
                'Your data is used for service personalization, communication, and security verification.'),
            SizedBox(height: 20.h),
            _buildSection('Data Sharing',
                'We do not share your personal information with third parties without your consent.'),
            SizedBox(height: 20.h),
            _buildSection('Security',
                'We use encryption and secure storage to protect your data.'),
            SizedBox(height: 20.h),
            _buildSection('User Rights',
                'You can request data deletion or modification anytime through your account settings.'),
            SizedBox(height: 10.h),
            _buildLastUpdatedSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFDFE1E7), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          _buildSectionContent(content),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1D1F2C),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 14.sp,
        color: Color(0xFF4A4C56),
      ),
    );
  }

  Widget _buildLastUpdatedSection() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Last Updated: June 2025',
            style: TextStyle(
              fontSize: 14.sp,fontWeight: FontWeight.w400,
              color: Color(0xFF1D1F2C),
            ),
          ),
        ],
      ),
    );
  }
}
