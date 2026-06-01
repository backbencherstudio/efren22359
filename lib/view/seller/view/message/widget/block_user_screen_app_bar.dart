import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockUserScreenAppBar extends StatelessWidget {
  const BlockUserScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new)),
            Text('Blocking', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w600),),
          ],
        ),
        SizedBox(height: 16.h),
        Divider(),
      ],
    );
  }
}
