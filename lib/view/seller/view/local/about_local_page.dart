import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/constant/app_icons.dart';
import 'package:local/view/seller/view/seller_parent/widget/seller_parent_screen_widget.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';

class AboutLocalPage extends StatelessWidget {
  const AboutLocalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomItemAppBar(title: 'About Local'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: ListView(
          children: [
            SizedBox(height: 30),
            _buildSection('Welcome to Local \n',
                'Local is the place where local communities come together to offer services, find jobs, sell goods, and more. We believe in fostering strong community ties and helping each other succeed.'),
            SizedBox(height: 20.h),
            _buildSection('What We Do \n',
                'Local is a community-powered platform that helps people find, offer, and request services, jobs, and items within their neighborhood. Whether you’re looking for a graphic designer, selling furniture, or offering handyman services, Local makes it easy to connect.'),
            SizedBox(height: 20.h),
            _buildSection('Why Local? \n',
                'Because local matters. Unlike other platforms, Local focuses on what’s nearby so you can discover real people, trusted services, and quick help without sifting endlessly through irrelevant posts. No fees, no noise – just useful local connections.'),
            SizedBox(height: 20.h),
            // _buildSection('Contact Us \n',
            //     'Have feedback or ideas? Reach out at:'),
            // Add the email row here
            SizedBox(height: 10),
            _buildContactUsRow(
              title: 'Contact Us',
              description: 'Have feedback or ideas? Reach out at:',
              email: 'hello@local.app',
            ),
            SizedBox(height: 20.h),
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
        border: Border.all(color: AppColors.grayBorderColor, width: 1.5),
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
        color: AppColors.darkTextColor,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColors.lightTextColor,
      ),
    );
  }

  // New Widget for the email with image
  Widget _buildContactUsRow({
    required String title,
    required String description,
    required String email,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grayBorderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Us Title
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.darkTextColor,  // Dark color for the title
            ),
          ),
          SizedBox(height: 8.h),  // Adds space between title and content
          // Description text
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextColor,  // Slightly gray for description
            ),
          ),
          SizedBox(height: 10.h),  // Space before the email row
          // Email Row
          Row(
            children: [
              // Email icon
              Image.asset(
                AppIcons.messageIcon,
                scale: 2.9,
              ),
              SizedBox(width: 8.w),
              // Email text
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,  // Purple color for the email
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
