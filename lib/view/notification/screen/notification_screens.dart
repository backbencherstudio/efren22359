import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';

import '../widget/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'message': 'You have received a new message from John.',
      'time': '2 mins ago',
    },
    {
      'message': 'Your appointment is scheduled for tomorrow at 10 AM.',
      'time': '1 hour ago',
    },
    {
      'message': 'Exclusive 30% off on all services, today only!',
      'time': '3 hours ago',
    },
    {
      'message': 'A new system update is available. Tap to learn more.',
      'time': '25 hours ago',
    },
    {
      'message': 'You have received a new message from John.',
      'time': '27 hours ago',
    },
    {
      'message': 'Your appointment is scheduled for tomorrow at 10 AM.',
      'time': '32 hour ago',
    },
    {
      'message': 'Exclusive 30% off on all services, today only!',
      'time': '32 hours ago',
    },
    {
      'message': 'A new system update is available. Tap to learn more.',
      'time': '32 hours ago',
    },
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomItemAppBar(title: 'Notification', hasSearch: true),
      body: Padding(
        padding: EdgeInsets.all(8.r),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                children: [
                  _buildNotificationSection('Today', 0, 3),
                  _buildNotificationSection('Yesterday', 3, 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildNotificationSection(String title, int startIndex, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), 
          itemCount: count,
          itemBuilder: (context, index) {
            return NotificationCard(
              message: notifications[startIndex + index]['message']!,
              time: notifications[startIndex + index]['time']!,
            );
          },
        ),
      ],
    );
  }
}
