import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/constant/app_images.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/modelview/auth/login_provider/login_screen_provider.dart';
import 'package:local/view/profile/bottom_sheet/confirm_logout_bottom_sheet.dart';
import 'package:local/view/profile/bottom_sheet/enable_2fa_phone_bottom_sheet.dart';
import 'package:local/view/profile/bottom_sheet/input_email_bottom_sheet.dart';
import 'package:local/view/profile/bottom_sheet/two_factor_auth_enabled_bottom_sheet.dart';
import 'package:local/view/profile/bottom_sheet/verify_code_bottom_sheet.dart';
import 'package:local/view/profile/utils/profile_utils.dart';
import 'package:provider/provider.dart';

import '../../../cors/constant/app_colors.dart';
import '../../../cors/constant/app_icons.dart';
import '../../../model/settings_option.dart';
import '../bottom_sheet/enable_2fa_bottom_sheet.dart';

class SettingsContentWidget extends StatefulWidget {
  const SettingsContentWidget({super.key});

  @override
  State<SettingsContentWidget> createState() => _SettingsContentWidgetState();
}

class _SettingsContentWidgetState extends State<SettingsContentWidget> {
  final List<SettingsOption> _settingsOptions = [
    SettingsOption(icon: AppIcons.settingsIcon, label: "General Settings"),
    SettingsOption(
      icon: AppIcons.notificationIcon,
      label: "Notifications Settings",
    ),
    SettingsOption(icon: AppIcons.profileIcon, label: "Accounts Settings"),
    SettingsOption(
      icon: AppIcons.gpsIcon,
      label: "Location GPS",
      hasToggle: true,
      toggleValue: true,
    ),
    SettingsOption(icon: AppIcons.securityIcon, label: "Security Settings"),
    SettingsOption(icon: AppIcons.privacyPolicy, label: "Privacy Policy"),
    SettingsOption(icon: AppIcons.aboutIcon, label: "About Local"),
  ];

  @override
  Widget build(BuildContext context) {
    // final loginLogoutProvider = context.watch<LoginScreenProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _settingsOptions.length + 1,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              if (index < _settingsOptions.length) {
                final option = _settingsOptions[index];
                return _buildSettingsOptionCard(
                  icon: option.icon,
                  label: option.label,
                  hasToggle: option.hasToggle,
                  toggleValue: option.toggleValue,
                  onToggleChanged: (newValue) {
                    setState(() {
                      option.toggleValue = newValue;
                    });
                    debugPrint("${option.label} toggle: $newValue");
                  },
                  onTap: () {
                    debugPrint("Tapped on ${option.label}");

                    if (option.label == "General Settings") {
                      Navigator.pushNamed(
                        context,
                        RouteName.generalSettingsScreen,
                      );
                    }

                    if (option.label == "Notifications Settings") {
                      Navigator.pushNamed(
                        context,
                        RouteName.notificationSettingsPage,
                      );
                    }

                    if (option.label == "Accounts Settings") {
                      // ProFileUtils.showAccountSettingsModal(context);
                      Navigator.pushNamed(context, RouteName.accountSettings);
                    }

                    if (option.label == "Security Settings") {
                      // ProFileUtils.showAccountSettingsModal(context);
                      Navigator.pushNamed(context, RouteName.securitySettings);
                    }

                    if (option.label == "Privacy Policy") {
                      // ProFileUtils.showAccountSettingsModal(context);
                      Navigator.pushNamed(context, RouteName.privacyPolicy);
                    }

                    if (option.label == "About Local") {
                      // ProFileUtils.showAccountSettingsModal(context);
                      Navigator.pushNamed(context, RouteName.aboutLocalPage);
                    }

                    // if (option.label == "Accounts Settings") {
                    //   showModalBottomSheet(
                    //     context: context,
                    //     isScrollControlled: true,
                    //     // This allows you to control the sheet height
                    //     builder: (context) {
                    //       return Enable2FABottomSheet(
                    //         onEmailVerify: () {
                    //           showModalBottomSheet(
                    //             context: context,
                    //             isScrollControlled: true,
                    //             // This allows you to control the sheet height
                    //             builder: (context) {
                    //               return InputEmailBottomSheet(
                    //                 onNext: (String value) {
                    //                   showModalBottomSheet(
                    //                     context: context,
                    //                     isScrollControlled: true,
                    //                     // This allows you to control the sheet height
                    //                     builder: (context) {
                    //                       return VerifyCodeBottomSheet(
                    //                         onVerify: (String value) {
                    //                           showModalBottomSheet(
                    //                             context: context,
                    //                             isScrollControlled: true,
                    //                             // This allows you to control the sheet height
                    //                             builder: (context) {
                    //                               return Enable2FABottomSheet(
                    //                                 onEmailVerify: () {},
                    //                                 onNumberVerify: () {
                    //                                   showModalBottomSheet(
                    //                                     context: context,
                    //                                     isScrollControlled:
                    //                                         true,
                    //                                     // This allows you to control the sheet height
                    //                                     builder: (context) {
                    //                                       return Enable2FAPhoneBottomSheet(
                    //                                         onNext: (
                    //                                           String value,
                    //                                         ) {
                    //                                           showModalBottomSheet(
                    //                                             context:
                    //                                                 context,
                    //                                             isScrollControlled:
                    //                                                 true,
                    //                                             // This allows you to control the sheet height
                    //                                             builder: (
                    //                                               context,
                    //                                             ) {
                    //                                               return VerifyCodeBottomSheet(
                    //                                                 onVerify: (
                    //                                                   String
                    //                                                   value,
                    //                                                 ) {
                    //                                                   showModalBottomSheet(
                    //                                                     context:
                    //                                                         context,
                    //                                                     isScrollControlled:
                    //                                                         true,
                    //                                                     // This allows you to control the sheet height
                    //                                                     builder: (
                    //                                                       context,
                    //                                                     ) {
                    //                                                       return TwoFactorAuthEnabledBottomSheet(
                    //                                                         onDone:
                    //                                                             () {},
                    //                                                       );
                    //                                                     },
                    //                                                   );
                    //                                                 },
                    //                                                 onResend:
                    //                                                     () {},
                    //                                               );
                    //                                             },
                    //                                           );
                    //                                         },
                    //                                       );
                    //                                     },
                    //                                   );
                    //                                 },
                    //                               );
                    //                             },
                    //                           );
                    //                         },
                    //                         onResend: () {},
                    //                       );
                    //                     },
                    //                   );
                    //                 },
                    //               );
                    //             },
                    //           );
                    //         },
                    //         onNumberVerify: () {
                    //           // Handle number verification
                    //         },
                    //       );
                    //     },
                    //   );
                    // }
                  },
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("Log Out tapped!");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.textFieldBox,
                          width: 1.w,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return ConfirmLogoutBottomSheet(
                                onConfirmLogout: () {
                                  context
                                      .read<LoginScreenProvider>()
                                      .logoutUser(context);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteName.loginScreen,
                                    (route) => false,
                                  );
                                },
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Image.asset(AppIcons.logOutIcon, scale: 1.8),
                            SizedBox(width: 16.w),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                color: AppColors.removeButtonColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptionCard({
    required String icon,
    required String label,
    required VoidCallback onTap,
    bool hasToggle = false,
    bool toggleValue = false,
    ValueChanged<bool>? onToggleChanged,
  }) {
    return GestureDetector(
      onTap: hasToggle ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.textFieldBox, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(icon, scale: 1.9),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (hasToggle)
              Transform.scale(
                scale: 0.8.w,
                child: Switch(
                  value: toggleValue,
                  onChanged: onToggleChanged,
                  activeColor: AppColors.primaryColor,
                  inactiveThumbColor: AppColors.lightTextColor,
                  inactiveTrackColor: AppColors.sliderBackgroundColor,
                ),
              )
            else
              Image.asset(AppIcons.arrowRightIcon, scale: 1.9),
          ],
        ),
      ),
    );
  }
}
