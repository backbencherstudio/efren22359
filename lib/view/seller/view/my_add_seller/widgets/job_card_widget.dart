import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../cors/constant/app_colors.dart';

class JobCardWidget extends StatefulWidget {
  final String category;
  final String jobTitle;
  final String location;
  final String timeAgo;
  final String price;
  final List<String> imageUrls;

  const JobCardWidget({
    Key? key,
    required this.category,
    required this.jobTitle,
    required this.location,
    required this.timeAgo,
    required this.price,
    required this.imageUrls,
  }) : super(key: key);

  @override
  _JobCardWidgetState createState() => _JobCardWidgetState();
}

class _JobCardWidgetState extends State<JobCardWidget> {
  int _currentIndex = 0; // To track the current image
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor, // Using cardColor from AppColors
        borderRadius: BorderRadius.circular(12.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //   //  offset: const Offset(0, 3), // Shadow effect
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Carousel with Indicator
          CarouselSlider.builder(
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Image.network(
                  widget.imageUrls[index], // Image URL from list
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: 200.h,
              viewportFraction: 1.0,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          // Carousel Indicator
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imageUrls.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? AppColors.primaryColor // Using primaryColor from AppColors
                        : AppColors.lightTextColor.withOpacity(0.6), // Using lightTextColor
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.2), // Light primaryColor
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      color: AppColors.primaryColor, // Using primaryColor for text
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                // Job title
                Text(
                  widget.jobTitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor, // Using darkTextColor
                  ),
                ),
                SizedBox(height: 8.h),
                // Location and time
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.lightTextColor, // Using lightTextColor
                      size: 16.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      widget.location,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.lightTextColor, // Using lightTextColor
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      widget.timeAgo,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.lightTextColor, // Using lightTextColor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Price
                Text(
                  widget.price,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor, // Using primaryColor for price
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
