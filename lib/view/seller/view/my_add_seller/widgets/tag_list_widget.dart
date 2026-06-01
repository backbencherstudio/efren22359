import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../cors/constant/app_colors.dart';

class TagListWidget extends StatelessWidget {
  /// The title displayed above the tags (e.g., "Tag:").
  final String title;

  /// A list of strings, where each string represents a tag to be displayed.
  final List<String> tags;

  /// Creates a [TagListWidget].
  const TagListWidget({
    Key? key,
    this.title = "Tag:",
    this.tags = const ["Remote", "Freelance", "Full-Time"],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w), // Overall padding for the widget.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left.
        mainAxisSize: MainAxisSize.min, // Take minimum vertical space.
        children: [
          // Title for the tag section
          Text(
            title,
            style: TextStyle(
              color: AppColors.darkTextColor, // Dark text color for the title.
              fontSize: 20.sp, // Scaled font size for responsiveness.
              fontWeight: FontWeight.w700, // Bold font weight.
            ),
          ),
          SizedBox(height: 12.h), // Spacing below the title.

          // Horizontal list of tags
          Wrap(
            spacing: 8.w, // Horizontal spacing between tags.
            runSpacing: 8.h, // Vertical spacing between rows of tags (if they wrap).
            children: tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.fieldColor, // Light background for the tag.
                  borderRadius: BorderRadius.circular(8.r), // Rounded corners for the tag.
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: AppColors.primaryColor, // Primary color for tag text.
                    fontSize: 14.sp, // Scaled font size.
                    fontWeight: FontWeight.w500, // Medium font weight.
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
