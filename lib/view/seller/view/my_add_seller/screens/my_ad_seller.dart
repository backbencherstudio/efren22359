import 'package:flutter/material.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/view/seller/view/my_add_seller/widgets/ad_listing_widget.dart';
import 'package:local/view/seller/view/my_add_seller/widgets/search_widget.dart';

class MyAdSeller extends StatelessWidget {
  const MyAdSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 40),
          SearchWidget(),
          Expanded(
            child: AdListingWidget(),
          ),
        ],
      ),
    );
  }
}
