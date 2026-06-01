import 'package:flutter/cupertino.dart';

class SettingsOption {
  final String icon;
  final String label;
  final bool hasToggle;
  bool toggleValue;

  SettingsOption({
    required this.icon,
    required this.label,
    this.hasToggle = false,
    this.toggleValue = false,
  });
}