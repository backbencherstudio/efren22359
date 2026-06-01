import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/view/widget/custom_item_app_bar.dart';
import '../../../profile/utils/profile_utils.dart';
import '../seller_parent/widget/seller_parent_screen_widget.dart';

final TextEditingController _currentPasswordController = TextEditingController();
final TextEditingController _newPasswordController = TextEditingController();
final TextEditingController _confirmPasswordController = TextEditingController();

bool _obscureTextCurrent = true;
bool _obscureTextNew = true;
bool _obscureTextConfirm = true;

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  bool _twoFactorAuthenticationEnabled = false;
  // final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomItemAppBar(title: 'Security Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildSettingTile(
              title: 'Two-Factor Authentication',
              value: _twoFactorAuthenticationEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _twoFactorAuthenticationEnabled = newValue;
                });

                // Call the method to show account settings modal when toggled
                if (newValue) {
                  ProFileUtils.showAccountSettingsModal(context);
                }
              },
            ),
            _buildTextFieldWithIcon(),
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

  Widget _buildTextFieldWithIcon() {
    return Column(
      children: [

        GestureDetector(
          onTap: () {
            // This will call the method to show the bottom sheet
            _showConfirmationBottomSheet('Change Email');
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Color(0xFFDFE1E7), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            'Change Email',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF1D1F2C),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 1),
        GestureDetector(
          onTap: () {

            _showConfirmationBottomSheet('Change Password');
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Color(0xFFDFE1E7), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF1D1F2C),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationBottomSheet(String label) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label == 'Change Password') ...[
                  Center(child: Image.asset('assets/images/dis.png', width: 80)),
                  SizedBox(height: 30),
                  Text(
                    'Change Password',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Current Password',
                    style: TextStyle(color: Color(0xFF777980), fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: 'Current Password',
                    obscureText: _obscureTextCurrent,
                    onTap: () {
                      setState(() {
                        _obscureTextCurrent = !_obscureTextCurrent;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'New Password',
                    style: TextStyle(color: Color(0xFF777980), fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    label: 'New Password',
                    obscureText: _obscureTextNew,
                    onTap: () {
                      setState(() {
                        _obscureTextNew = !_obscureTextNew;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Confirm Password',
                    style: TextStyle(color: Color(0xFF777980), fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: _obscureTextConfirm,
                    onTap: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                  ),
                ]
                else ...[
                  Center(child: Image.asset('assets/images/dis.png', width: 80)),
                  SizedBox(height: 30),
                  Text(
                    'Change Email',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Current Email',
                    style: TextStyle(color: Color(0xFF777980), fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: 'Current Email',
                    obscureText: _obscureTextCurrent,
                    onTap: () {
                      setState(() {
                        _obscureTextCurrent = !_obscureTextCurrent;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'New Email',
                    style: TextStyle(color: Color(0xFF777980), fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    label: 'New Email',
                    obscureText: _obscureTextNew,
                    onTap: () {
                      setState(() {
                        _obscureTextNew = !_obscureTextNew;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Password',
                    style: TextStyle(color: Color(0xFF777980), fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Password',
                    obscureText: _obscureTextConfirm,
                    onTap: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                  ),
                ],
                SizedBox(height: 30.h),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff5D18EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          label == 'Change Email'
                              ? 'Update Email'
                              : 'Update Password',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 120),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onTap,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xFFDFE1E7)),
        ),
      ),
    );
  }
}
