import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/view/auth/login/start/onboarding.dart';
import 'package:local/view/auth/signup/screen/sign_up_screen.dart';

import '../../cors/routes/routes_name.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "image": 'assets/onboarding/onboarding_1.png',
      "titleWidget": "Find Trusted Local Help",
      "subtitle":
          'Explore handyman services, gigs, and community posts right in your neighborhood',
    },
    {
      "image": 'assets/onboarding/onboarding_2.png',
      "titleWidget": "List Your Skills for Free",
      "subtitle":
          'Offer your services, post jobs, or sell items with no fees, no middlemen.',
    },
    {
      "image": 'assets/onboarding/onboarding_3.png',
      "titleWidget": "Connect. Chat. Get Work Done.",
      "subtitle":
          'Message directly, respond to posts, and complete tasks with people nearby.',
    },
  ];

  void _goToLogin() {
    // Navigate to the login screen
    Navigator.pushNamed(
      context,
      RouteName.loginOnboarding,
    ); // Example route name
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin(); // Navigate to login on the last page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final item = onboardingData[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        item["titleWidget"]!,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff212121),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        item["subtitle"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff757575),
                        ),
                      ),
                      Image.asset(item["image"]!, height: 300.h),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 7.h,
                width: _currentPage == index ? 28.w : 15.w,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index
                          ? Color(0xff5D18EB)
                          : Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 45.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () => _nextPage(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5D18EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 20.w,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == onboardingData.length - 1
                                ? "Get Started "
                                : "Next  ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          if (_currentPage <
                              onboardingData.length -
                                  1) // Only show arrow if not on the last page
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20.sp, // Right arrow icon size
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
