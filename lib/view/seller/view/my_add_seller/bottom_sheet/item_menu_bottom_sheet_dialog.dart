import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/cors/routes/routes_name.dart';

void showBottomSheetDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle at the top
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 26),
            // Edit button with outline
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  side: BorderSide(color: AppColors.borderColor, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle Edit action
                  Navigator.pushNamed(context, RouteName.editPostScreen);
                  print("Edit tapped");
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Delete button with red text and outline
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.rejectionTextColor, backgroundColor: Colors.white, // Red text color
                  side: BorderSide(color: AppColors.rejectionBorderColor, width: 1), // Outline border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle Delete action
                  Navigator.pop(context);
                  print("Delete tapped");
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      );
    },
  );
}
