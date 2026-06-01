import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/utils/custom_bottom_report_model_sheet.dart';
import 'package:local/view/seller/model/message/chat_user_model.dart';
import 'package:local/view/seller/view/message/modal_view/chat_user_provider.dart';
import 'package:provider/provider.dart';

import '../../view/widget/primary_outline_button.dart';
import '../constant/app_colors.dart';
import 'block_toggle_bottom_sheet.dart';

class CustomChatRoomBottomSheet {
  static void showMenuBottomSheet({context,required ChatUserModel userModel}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.fieldColor,
                    borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 60.h,child: Image.asset(userModel.photoUrl)),
                    Text(userModel.name, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: PrimaryOutlineButton(
                  text: 'Report',
                  onPressed: () {
                    Navigator.pop(context);
                    CustomBottomReportModelSheet.showReportBottomSheet(context, userModel.id);
                  },
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: PrimaryOutlineButton(
                  text: 'Block',
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                    BlockToggleBottomSheet.showMenuBottomSheet(
                      context: context,
                      name: userModel.name,
                      userId: userModel.id,
                      isBlocking: true,
                      provider: Provider.of<ChatUserProvider>(context, listen: false),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: PrimaryOutlineButton(
                  text: 'Delete Conversation',
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
