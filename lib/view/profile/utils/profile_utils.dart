import 'package:flutter/material.dart';

import '../bottom_sheet/enable_2fa_bottom_sheet.dart';
import '../bottom_sheet/enable_2fa_phone_bottom_sheet.dart';
import '../bottom_sheet/input_email_bottom_sheet.dart';
import '../bottom_sheet/two_factor_auth_enabled_bottom_sheet.dart';
import '../bottom_sheet/verify_code_bottom_sheet.dart';

class ProFileUtils {
  ProFileUtils._();

  static void showAccountSettingsModal(BuildContext context) {
    // Close the currently open bottom sheet if any (this avoids popping the main screen)
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Enable2FABottomSheet(
          onEmailVerify: () {
            // Close the current bottom sheet and show a new one
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return InputEmailBottomSheet(
                  onNext: (String value) {
                    // Close the current bottom sheet and show a new one
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return VerifyCodeBottomSheet(
                          onVerify: (String value) {
                            // Close the current bottom sheet and show a new one
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Enable2FABottomSheet(
                                  onEmailVerify: () {},
                                  onNumberVerify: () {
                                    // Close the current bottom sheet and show a new one
                                    if (Navigator.canPop(context)) {
                                      Navigator.pop(context);
                                    }

                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Enable2FAPhoneBottomSheet(
                                          onNext: (String value) {
                                            // Close the current bottom sheet and show a new one
                                            if (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }

                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return VerifyCodeBottomSheet(
                                                  onVerify: (String value) {
                                                    // Close the current bottom sheet and show a new one
                                                    if (Navigator.canPop(
                                                      context,
                                                    )) {
                                                      Navigator.pop(context);
                                                    }

                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (context) {
                                                        return TwoFactorAuthEnabledBottomSheet(
                                                          onDone: () {
                                                            Navigator.pop(context);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  onResend: () {},
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }, ifEmailVerified: true,
                                );
                              },
                            );
                          },
                          onResend: () {},
                        );
                      },
                    );
                  },
                );
              },
            );
          },
          onNumberVerify: () {
            // Close the current bottom sheet and handle number verification
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }, ifEmailVerified: false,
        );
      },
    );
  }
}
