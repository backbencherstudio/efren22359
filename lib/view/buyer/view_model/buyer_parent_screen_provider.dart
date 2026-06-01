import 'package:flutter/material.dart';
import 'package:local/view/home/screen/home_screen.dart';


class BuyerParentScreenProvider with ChangeNotifier {
  List<Widget> screens = [
    // HomeScreen(),
    // HomeScreen(),
    // HomeScreen(),
    // HomeScreen(),
    // HomeScreen(),
  ];
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
    debugPrint("Selected Index: $selectedIndex");
  }
}
