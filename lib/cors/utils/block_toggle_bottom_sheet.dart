import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/seller/view/message/modal_view/chat_user_provider.dart';
import '../../view/widget/primary_button.dart';
import '../../view/widget/primary_outline_button.dart';
import '../constant/app_colors.dart';

class BlockToggleBottomSheet {
  static void showMenuBottomSheet({
    required context,
    required bool isBlocking,
    required String name,
    required String userId,
    required ChatUserProvider provider,
  }) {
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
              Text(
                isBlocking ? 'Block $name' : 'Unblock $name',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: AppColors.darkTextColor,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                isBlocking ? 'They\'ll be removed as your connection and won\'t be able to message you' : 'If you unblock $name, they may be able to see your ad or contact you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.lightTextColor,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: PrimaryButton(
                  text: isBlocking ? 'Block' : 'Unblock',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    provider.unblockUser(userId);
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: PrimaryOutlineButton(
                  text: "Cancel",
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
