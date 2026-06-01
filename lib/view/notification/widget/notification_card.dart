import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final String message;
  final String time;

  const NotificationCard({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 10),
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}