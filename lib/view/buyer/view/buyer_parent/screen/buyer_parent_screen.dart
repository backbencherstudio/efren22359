import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/buyer_parent_screen_provider.dart';
import '../widget/buyer_parent_screen_widget.dart';

class BuyerParentScreen extends StatefulWidget {
  const BuyerParentScreen({super.key});

  @override
  State<BuyerParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<BuyerParentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Consumer<BuyerParentScreenProvider>(
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
                child: const BuyerParentScreenWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
