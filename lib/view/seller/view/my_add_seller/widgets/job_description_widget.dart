import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';

class JobDescriptionWidget extends StatelessWidget {
  /// The main descriptive text for the job.
  final String description;

  /// A list of bullet points detailing aspects of the job.
  final List<String> details;

  /// Creates a [JobDescriptionWidget].
  const JobDescriptionWidget({
    Key? key,
    this.description = "Full text of what the job entails",
    this.details = const [
      "Responsibilities (e.g., HTML/CSS/React dev)",
      "Duration (e.g., 2-week sprint)",
      "Hydrating mask",
      "Deliverables (e.g., landing page, dashboard, etc.)",
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w), // Overall padding for the widget.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left.
        mainAxisSize: MainAxisSize.min, // Take minimum vertical space.
        children: [
          // Job Description Title
          Text(
            "Job Description:",
            style: TextStyle(
              color: AppColors.darkTextColor, // Dark text color for the title.
              fontSize: 20.sp, // Scaled font size for responsiveness.
              fontWeight: FontWeight.w700, // Bold font weight.
            ),
          ),
          SizedBox(height: 12.h), // Spacing below the title.

          // Main Description Text
          Text(
            description,
            style: TextStyle(
              color: AppColors.darkTextColor, // Dark text color for the description.
              fontSize: 16.sp, // Scaled font size.
              fontWeight: FontWeight.w400, // Regular font weight.
            ),
          ),
          SizedBox(height: 12.h), // Spacing below the description.

          // Bulleted List of Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details.map((detail) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h), // Spacing between list items.
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.h, right: 8.w), // Adjust margin for bullet point.
                      width: 6.w, // Scaled width for the bullet.
                      height: 6.h, // Scaled height for the bullet.
                      decoration: BoxDecoration(
                        color: AppColors.darkTextColor, // Color of the bullet point.
                        shape: BoxShape.circle, // Circular shape for the bullet.
                      ),
                    ),
                    Expanded(
                      child: Text(
                        detail,
                        style: TextStyle(
                          color: AppColors.darkTextColor, // Dark text color for list items.
                          fontSize: 16.sp, // Scaled font size.
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
