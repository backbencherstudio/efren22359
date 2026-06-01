import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/constant/app_icons.dart';
import 'package:local/view/widget/primary_button.dart';
import 'package:local/view/widget/primary_outline_button.dart';
import '../../widget/custom_popup_drop_down.dart';

class HomeFilterBottomSheet extends StatelessWidget {
  const HomeFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
                color: Colors.grey
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Text(
                'Filter',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: AppColors.darkTextColor,),
              ),
              Spacer(),
              GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.close, size: 30)),
            ],
          ),
          Divider(),
          Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: AppColors.lightTextColor,),
          ),
          SizedBox(height: 8.h,),
          Center(child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildContainer(context: context, topLeft: 16, topRight: 0, bottomLeft: 16, bottomRight: 0, text: 'Min'),
              _buildContainer(context: context, topLeft: 0, topRight: 16, bottomLeft: 0, bottomRight: 16, text: 'Max'),
            ],
          )),
          SizedBox(height: 10.h),
          Divider(),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text("Distance", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.darkTextColor,),),
              Spacer(),
              Wrap(
                children: [
                  Image.asset(AppIcons.locationIcon, scale: 2,),
                  SizedBox(width: 4.w,),
                  Text('25 km', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.darkTextColor,),)
                ],
              )
            ],
          ),
          SizedBox(height: 10.h,),
          RangeSlider(
            values: RangeValues(100, 2000),
            min: 0,
            max: 5000,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.fieldColor,
            onChanged: (RangeValues values) {},
          ),
          SizedBox(height: 10.h),
          Divider(),
          SizedBox(height: 10.h),
          CustomPopupDropdown(title: 'Select Category', hint: 'Select', value: 'Services', items: [], onChanged: (_) {},),
          SizedBox(height: 20.h,),
          CustomPopupDropdown(title: 'Select Sub Category', hint: 'Select', value: 'Automotive Services',items: [], onChanged: (_) {},),
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: PrimaryOutlineButton(text: 'Clear All')),
                SizedBox(width: 8.w,),
                Expanded(child: PrimaryButton(text: 'Apply Filter')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainer({required context,required double topLeft, required double topRight, required double bottomLeft, required double bottomRight, required String text}) {
    return Container(
      height: 50.h,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$text-\$", style: TextStyle(color: AppColors.lightTextColor),),
            Expanded(
              child: TextField(
                style: TextStyle(color: AppColors.darkTextColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
