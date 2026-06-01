import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../modelview/disable_account/disable_account.dart';
import '../../../widget/custom_item_app_bar.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});
  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool _pushNotificationsEnabled = true;

  List<Map<String, String>> dangerZoneOptions(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context);
    return [
      {
        'image': 'assets/images/accountPro.png',
        'label': provider.isDisabled ? 'Reactivate Account' : 'Disable Account',
      },
      {'image': 'assets/images/dlt.png', 'label': 'Delete Account'},
    ];
  }

  void _showConfirmationBottomSheet(String label) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final provider = Provider.of<AccountProvider>(context);

        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/dis.png', width: 50.w)),
              SizedBox(height: 30),
              Center(child: Image.asset('assets/images/disable.png', width: 50.w)),
              SizedBox(height: 20),
              Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D1F2C),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  label.contains('Disable')
                      ? 'Disabling your account is temporary. You can \n  reactivate it anytime.'
                      : label.contains('Reactivate')
                      ? 'Reactivating your account will restore full access.'
                      : 'This action is permanent and cannot be \n          undone. All your data will be lost.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF777980),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                        if (label.contains('Disable') ||
                            label.contains('Reactivate')) {
                          final success =
                          await Provider.of<AccountProvider>(context,
                              listen: false)
                              .disableAccount();

                          if (success) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                  Text(provider.message ?? 'Done')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(provider.message ??
                                      'Failed to update account')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB3D4D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      child: provider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        label.contains('Disable')
                            ? 'Yes, Disable'
                            : label.contains('Reactivate')
                            ? 'Yes, Reactivate'
                            : 'Yes, Delete',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final options = dangerZoneOptions(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomItemAppBar(title: 'Account Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingTile(
              title: 'Private Account',
              value: _pushNotificationsEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _pushNotificationsEnabled = newValue;
                });
              },
            ),
            SizedBox(height: 30.h),
            Text(
              'Danger Zone',
              style: TextStyle(color: const Color(0xFFA5A5AB), fontSize: 16),
            ),
            SizedBox(height: 10.h),
            ...options.map((option) {
              return _buildDangerZoneOption(
                iconPath: option['image']!,
                label: option['label']!,
              );
            }).toList(),
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
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFDFE1E7), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF1D1F2C),
            ),
          ),
          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFD2D2D5),
              activeTrackColor: const Color(0xFF5E17EB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZoneOption({
    required String iconPath,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        _showConfirmationBottomSheet(label);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFDFE1E7), width: 1.5),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(iconPath),
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
