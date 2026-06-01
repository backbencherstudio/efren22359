import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../modelview/home/report_post_provider.dart';
import '../../view/widget/primary_button.dart';
import '../../view/widget/primary_outline_button.dart';
import '../constant/app_colors.dart';

class CustomBottomReportModelSheet {
  static void showReportBottomSheet(BuildContext context, String postId) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      context: context,
      builder: (context) {
        return Consumer<ReportPostProvider>(
          builder: (context, reportProvider, child) {
            if (reportProvider.reportTypeId == null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Why are you reporting this ad?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Text(
                      'If someone is immediate danger, get help before reporting to Local',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.separated(
                        itemCount: reportProvider.reportTypeList.length,
                        itemBuilder: (context, index) {
                          return _buildReportOption(
                            reportProvider: reportProvider,
                            text: reportProvider.reportTypeList[index].name,
                            onTap:
                                () {
                                  reportProvider.setReportTypeId(
                                    reportProvider.reportTypeList[index].id,
                                  );
                                  reportProvider.setReportType(
                                    reportProvider.reportTypeList[index].name,
                                  );
                                }
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(height: 4.h),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: PrimaryOutlineButton(text: 'Cancel', onPressed: () {
                        reportProvider.resetReport();
                        Navigator.pop(context);
                      },),
                    ),
                  ],
                ),
              );
            } else if (reportProvider.reportDetail == null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Why are you reporting this ad?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Text(
                      'If someone is immediate danger, get help before reporting to Local',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.separated(
                        itemCount: reportProvider.reportDetailList.length,
                        itemBuilder: (context, index) {
                          return _buildReportOption(
                            reportProvider: reportProvider,
                            text: reportProvider.reportDetailList[index].name,
                            onTap:
                                () {
                                  reportProvider.setReportDetail(
                                    reportProvider.reportDetailList[index].name,
                                  );
                                  reportProvider.setReportDetailsId(
                                    reportProvider.reportDetailList[index].id,
                                  );
                                }
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(height: 4.h),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: PrimaryOutlineButton(text: 'Cancel', onPressed: () {
                        reportProvider.resetReport();
                        Navigator.pop(context);
                      },),
                    ),
                  ],
                ),
              );
            } else if (reportProvider.reportDetailId != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you about to submit a report?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Text(
                      'We only remove content that goes against Community Standards',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text('Report Details'),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                        color: AppColors.fieldColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(reportProvider.reportType!),
                            SizedBox(height: 8.h),
                            Divider(),
                            SizedBox(height: 8.h),
                            Text(reportProvider.reportDetail!),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.fieldColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12.r),
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                        dashPattern: const [6, 5],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Fake reviews are dishonest, fabricated feedback intended to mislead consumers about a products quality or value',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.9,child: PrimaryButton(text: 'Submit', onPressed: () async {
                      final response = await reportProvider.reportPost(postId);
                      if (response) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Report submitted successfully'),
                          ),
                        );
                        reportProvider.resetReport();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to submit report'),
                          ),
                        );
                      }
                      Navigator.pop(context);
                    })),
                    SizedBox(height: 10.h,),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }

  static Widget _buildReportOption({
    required ReportPostProvider reportProvider,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColors.fieldColor, width: 3),
          ),
          child: Row(
            children: [Text(text), Spacer(), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    );
  }
}