import 'package:flutter/material.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/auth/reset_pass_otp/reset_pass_otp_screen.dart';
import 'package:local/view/home/screens/home_service_detail/home_service_details_screen.dart';
import 'package:local/view/home/screens/home_service_result/home_service_result_screen.dart';
import 'package:local/view/notification/screen/notification_screens.dart';
import 'package:local/view/profile/widgets/settings_content_widget.dart';
import 'package:local/view/seller/view/local/about_local_page.dart';
import 'package:local/view/seller/view/message/screens/block_user_screen/block_user_screen.dart';
import 'package:local/view/seller/view/message/screens/chat_room/chat_room_screen.dart';
import 'package:local/view/auth/login/screen/profile/profile_creation.dart';
import 'package:local/view/auth/set_password/set_password_screen.dart';
// import 'package:local/view/auth/login/forgot_password/Email_field_provider.dart';
// import 'package:local/view/auth/login/screen/forgot_password/email_field_provider.dart';
import 'package:local/view/auth/signup/screen/sign_up_screen.dart';
import 'package:local/view/auth/login/start/onboarding.dart';
import 'package:local/view/seller/view/account/account_settings.dart';
import 'package:local/view/profile/screen/general_settings_screen.dart';
import 'package:local/view/profile/screen/profile_settings.dart';
import 'package:local/view/seller/view/my_add_seller/screens/ad_rejected_screen.dart';
import 'package:local/view/seller/view/my_add_seller/screens/edit_post.dart';
import 'package:local/view/seller/view/profile/seller_profile.dart';
import 'package:local/view/seller/view/post/screens/service_post_screen.dart';
import 'package:local/view/seller/view/security/security_settings.dart';
import 'package:local/view/seller/view/seller_parent/screen/seller_parent_screen.dart';

import '../../view/auth/login/screen/forgot_password/forgot_password_screen.dart';
import '../../view/auth/login/screen/login_screen.dart';
import '../../view/auth/login/screen/profile/profile_creation_screen.dart';
import '../../view/auth/validate_otp/screen/otp_screen.dart';
import '../../view/home/screen/home_screen.dart';
import '../../view/home/screens/post_creator_profile_screen/post_creator_profile.dart';
import '../../view/onboarding/onboarding_screen.dart';
import '../../view/seller/view/message/screens/add_response_screen/add_response_list_screen.dart';
import '../../view/seller/view/message/screens/chat_room/temp.dart';
import '../../view/seller/view/message/screens/response_message/response_message_screen.dart';
import '../../view/seller/view/notification/notification_settings_page.dart';
import '../../view/seller/view/policy/privacy_policy.dart';
import '../../view/splash/screen/splash_screen.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> routes = {

     '/': (context) => SplashScreen(),

     RouteName.splashScreen: (context) => const SplashScreen(),
     RouteName.onboardingScreen: (context) => const OnboardingScreen(),
     RouteName.homeScreen: (context) => const HomeScreen(),
     RouteName.sellerParentScreen: (context) => const SellerParentScreen(),
     RouteName.homeServiceResultScreen: (context) => const HomeServiceResultScreen(),
     RouteName.homeServiceDetailScreen: (context) => const HomeServiceDetailsScreen(),
     RouteName.notificationScreen: (context) => NotificationScreen(),
     RouteName.adRejectedScreen: (context) => const AdRejectedScreen(),
     RouteName.editPostScreen: (context) => const EditPost(),
     RouteName.blockUserScreen: (context) => const BlockUserScreen(),
     RouteName.chatRoomScreen: (context) => const ChatRoomScreen(),
     RouteName.responseMessageScreen: (context) => const ResponseMessageScreen(),
     RouteName.loginOnboarding: (context) => const Onboarding(),
     RouteName.loginScreen: (context) => const LoginScreen(),
     RouteName.signUpScreen: (context) => const SignUpScreen(),
     RouteName.profileCreationScreen: (context) => const ProfileCreationScreen(),
     RouteName.profileCreation: (context) => const ProfileCreation(),
     RouteName.forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
     RouteName.otpScreen: (context) => const OtpScreen(),
     RouteName.resetPassOtpScreen: (context) => const ResetPassOtpScreen(),
     RouteName.servicePostScreen: (context) => const ServicePostScreen(),
     RouteName.sellerProfile: (context) => const SellerProfile(),
     RouteName.notificationSettingsPage: (context) => const NotificationSettingsPage(),
     RouteName.profileSettings: (context) => const ProfileSettings(),
     RouteName.generalSettingsScreen: (context) => const GeneralSettingsScreen(),
     RouteName.accountSettings: (context) => const AccountSettings(),
     RouteName.securitySettings: (context) => const SecuritySettings(),
     RouteName.privacyPolicy: (context) => const PrivacyPolicy(),
     RouteName.aboutLocalPage: (context) => const AboutLocalPage(),
     RouteName.setPasswordScreen: (context) => const SetPasswordScreen(),
     RouteName.addResponseListScreen: (context) => const AddResponseListScreen(),
     RouteName.postCreatorProfile: (context) => const PostCreatorProfile(),
     RouteName.temp: (context) => const Temp(),

  };
}