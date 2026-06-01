import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/view/widget/custom_app_bar.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';
import '../seller_parent/widget/seller_parent_screen_widget.dart';
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});
  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}
class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _jobServiceUpdatesEnabled = false;
  bool _messageAlertsEnabled = false;
  bool _promotionsOffersEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomItemAppBar(title: 'Notifications Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildSettingTile(
              title: 'Push Notifications',
              value: _pushNotificationsEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _pushNotificationsEnabled = newValue;
                });
              },
            ),
            _buildSettingTile(
              title: 'Email Notifications',
              value: _emailNotificationsEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _emailNotificationsEnabled = newValue;
                });
              },
            ),
            _buildSettingTile(
              title: 'Job & Service Updates',
              value: _jobServiceUpdatesEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _jobServiceUpdatesEnabled = newValue;
                });
              },
            ),
            _buildSettingTile(
              title: 'Message Alerts',
              value: _messageAlertsEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _messageAlertsEnabled = newValue;
                });
              },
            ),
            _buildSettingTile(
              title: 'Promotions & Offers',
              value: _promotionsOffersEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _promotionsOffersEnabled = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSettingTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      // Responsive vertical margin
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      // Responsive padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFDFE1E7), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF1D1F2C),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFD2D2D5),
            activeTrackColor: Color(0xFF5E17EB),
          ),
        ],
      ),
    );
  }
}