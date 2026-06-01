import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';

import '../../../../widget/border_widget.dart';
import '../widgets/ad_rejection_widget.dart';
import '../widgets/deadline_contact_info_widget.dart';
import '../widgets/job_card_widget.dart';
import '../widgets/job_description_widget.dart';
import '../widgets/posted_by_widget.dart';
import '../widgets/tag_list_widget.dart';

class AdRejectedScreen extends StatelessWidget {
  const AdRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(''),
        // Empty title to center the content
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'Ad',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),
        ],
        elevation: 0,
        // Removes shadow
        backgroundColor: Colors.white,
        // Makes the background white
        foregroundColor: Colors.black, // Makes the text/icons black
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Ad is Rejected!",
                style: TextStyle(
                  color: AppColors.rejectionTextColor,
                  fontSize: 18.sp, // Scaled font size
                  fontWeight: FontWeight.bold, // Bold font weight
                ),

              ),
              SizedBox(height: 12.h), // Space between the text and widget
              // AdRejectionWidget(),
              SizedBox(height: 16.h,),

              JobCardWidget(
                category: 'Design/Development',
                jobTitle: 'Frontend Developer Need',
                location: 'San Francisco, CA',
                timeAgo: '10h ago',
                price: '\$1200',
                imageUrls: [
                  'https://picsum.photos/200/300',
                  'https://picsum.photos/200/300',
                  'https://picsum.photos/200/300',
                ],
              ),
              BorderWidget(),
              JobDescriptionWidget(),
              BorderWidget(),
              //SizedBox(height: 16.h,),
              TagListWidget(),
              BorderWidget(),
              PostedByWidget(),
              BorderWidget(),
              DeadlineContactInfoWidget(),

              SizedBox(height: 60,),

            ],
          ),
        ),
      ),
    );
  }
}
