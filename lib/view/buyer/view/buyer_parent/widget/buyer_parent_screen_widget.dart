import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/buyer_parent_screen_provider.dart';

class BuyerParentScreenWidget extends StatelessWidget {
  const BuyerParentScreenWidget({super.key});

  static const _tabs = [
    {'iconPath': 'assets/icons/home.png', 'title': 'Home'},
    {'iconPath': 'assets/icons/add.png', 'title': 'My Ad'},
    {'iconPath': 'assets/icons/add_plus.png', 'title': 'Post'},
    {'iconPath': 'assets/icons/message.png', 'title': 'Message'},
    {'iconPath': 'assets/icons/profile.png', 'title': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h, // Adjusted height to fit icon and title
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _tabs.length,
          (index) => _TabButton(
            index: index,
            iconPath: _tabs[index]['iconPath']!,
            title: _tabs[index]['title']!,
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final int index;
  final String iconPath;
  final String title;

  const _TabButton({
    required this.index,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyerParentScreenProvider>(
      builder: (_, provider, __) {
        final isSelected = provider.selectedIndex == index;

        return GestureDetector(
          onTap:
              () =>
                  context.read<BuyerParentScreenProvider>().onSelectedIndex(index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  width: 24.w,
                  height: 24.h,
                  color:
                      isSelected
                          ? const Color(0xff5E17EB)
                          : const Color(0xff777980),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color:
                        isSelected
                            ? const Color(0xff5E17EB)
                            : const Color(0xff777980),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
