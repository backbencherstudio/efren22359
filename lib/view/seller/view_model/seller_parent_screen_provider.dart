import 'package:flutter/material.dart';
import 'package:local/view/home/screen/home_screen.dart';
import 'package:local/view/profile/screen/profile_screen.dart';
import 'package:local/view/seller/view/message/screen/message_screen.dart';
import 'package:local/view/seller/view/post/screens/post_selection_screen.dart';
import 'package:local/view/seller/view/profile/seller_profile.dart';

import '../view/my_add_seller/screens/my_ad_seller.dart';


class SellerParentScreenProvider with ChangeNotifier {
  List<Widget> screens = [
    HomeScreen(),
    MyAdSeller(),
    PostSelectionScreen(),
    MessageScreen(),
    SellerProfile(),
  ];
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
    debugPrint("Selected Index: $selectedIndex");
  }
}

