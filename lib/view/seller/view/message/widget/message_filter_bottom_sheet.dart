import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';

import '../../../../widget/primary_button.dart';
import '../../../../widget/primary_outline_button.dart';

class MessageFilterBottomSheet extends StatefulWidget {
  const MessageFilterBottomSheet({super.key});

  @override
  State<MessageFilterBottomSheet> createState() =>
      _MessageFilterBottomSheetState();
}

class _MessageFilterBottomSheetState extends State<MessageFilterBottomSheet> {
  bool _isUnreadOnly = false;
  bool _isReadMessages = false;
  bool _isLastHours = false;
  bool _isLastDays = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text('Filter', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: AppColors.darkTextColor,),),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 30),
              ),
            ],
          ),
          Divider(),
          Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.darkTextColor,),),
          SizedBox(height: 10.h),
          _buildOption('Unread only', _isUnreadOnly, (value) {setState(() {_isUnreadOnly = value;});}),
          _buildOption('Read Messages', _isReadMessages, (value) {setState(() {_isReadMessages = value;});}),
          Divider(),
          Text('Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.darkTextColor,),),
          SizedBox(height: 10.h),
          _buildOption('Last 24 Hours', _isLastHours, (value) {setState(() {_isLastHours = value;});}),
          _buildOption('Last 7 Days', _isLastDays, (value) {setState(() {_isLastDays = value;});}),
          Divider(),
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: PrimaryOutlineButton(text: 'Clear')),
                SizedBox(width: 8.w,),
                Expanded(child: PrimaryButton(text: 'Apply')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(String optionTitle, bool checkField, Function(bool) onChanged) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 22.h,
              width: 22.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45.r),
                border: Border.all(color: checkField ? AppColors.primaryColor : Colors.grey.shade400, width: 1.5,),
              ),
            ),
            Checkbox(
              value: checkField,
              onChanged: (bool? value) {onChanged(value ?? false);},
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.r),),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Text(optionTitle, style: TextStyle(fontSize: 14.sp, color: AppColors.lightTextColor)),
      ],
    );
  }
}