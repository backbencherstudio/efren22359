import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:local/cors/constant/app_icons.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/cors/utils/custom_bottom_menu_model_sheet.dart';

class MessageScreenAppBar extends StatelessWidget {
  const MessageScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Message', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w600),),
            GestureDetector(
              onTap: () => CustomBottomMenuModelSheet.showMenuBottomSheet(context: context, title: 'Blocked User', onTap: (){Navigator.pushNamed(context, RouteName.blockUserScreen);}),
              child: Image.asset(AppIcons.moreHorizIcon, scale: 1.5,)
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
