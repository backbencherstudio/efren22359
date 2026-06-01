import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cors/constant/app_colors.dart';

class UserName extends StatelessWidget {
  final String userName;
  final String userLocation;

  const UserName({
    super.key,
    required this.userName,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // User Name
        Text(
          userName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          userLocation,
          style: TextStyle(
            color: const Color(0xFF777980),
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
