import 'package:flutter/material.dart';
import 'package:local/view/seller/view_model/my_ad_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../modelview/auth/login_provider/login_screen_provider.dart';
import '../../../../../modelview/home/report_post_provider.dart';
import '../../../../../modelview/profile/my_post_details_provider.dart';
import '../../../view_model/seller_parent_screen_provider.dart';
import '../widget/seller_parent_screen_widget.dart';

class SellerParentScreen extends StatefulWidget {
  const SellerParentScreen({super.key});

  @override
  State<SellerParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<SellerParentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<LoginScreenProvider>().getMe();
      await context.read<MyPostDetailsProvider>().getMyPostList();
      await context.read<MyAdProvider>().getMyAds();
      await context.read<MyAdProvider>().getFavoritePost();
      await context.read<MyAdProvider>().getMyPendingAds();
      await context.read<ReportPostProvider>().getReportTypeList();
      await context.read<ReportPostProvider>().getReportDetailsList();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Consumer<SellerParentScreenProvider>(
            builder: (context, parentScreenProvider, child) {
              if (parentScreenProvider.screens.isEmpty ||
                  parentScreenProvider.selectedIndex < 0 ||
                  parentScreenProvider.selectedIndex >=
                      parentScreenProvider.screens.length) {
                return const Center(child: Text('No screens available'));
              }

              final validScreens =
                  parentScreenProvider.screens
                      .asMap()
                      .entries
                      .where((entry) => entry.value != null)
                      .map((entry) => entry.value!)
                      .toList();

              if (validScreens.isEmpty) {
                return const Center(child: Text('No valid screens available'));
              }

              final adjustedIndex = parentScreenProvider.selectedIndex.clamp(
                0,
                validScreens.length - 1,
              );

              return IndexedStack(index: adjustedIndex, children: validScreens);
            },
          ),
          Transform.translate(
            offset: const Offset(0, -15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const SellerParentScreenWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
