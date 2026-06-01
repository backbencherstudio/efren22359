// app_providers.dart
import 'package:local/modelview/auth/set_password/set_password_provider.dart';
import 'package:local/cors/provider/provider_Set/sign_up_provider.dart';
import 'package:local/modelview/auth/reset_pass_otp/reset_pass_otp_provider.dart';

import 'package:local/modelview/home/category_provider.dart';
import 'package:local/modelview/home/edit_post_provider.dart';
import 'package:local/modelview/home/get_post_by_category_provider.dart';
import 'package:local/modelview/home/location_provider.dart';
import 'package:local/modelview/home/report_post_provider.dart';
import 'package:local/modelview/profile/edit_profile_provider.dart';
import 'package:local/modelview/profile/my_post_details_provider.dart';
import 'package:local/view/seller/view/message/modal_view/chat_response_provider.dart';
import 'package:provider/provider.dart';
import 'package:local/view/seller/view_model/post_viewmodel.dart';
import 'package:local/view/buyer/view_model/buyer_parent_screen_provider.dart';
import 'package:local/view/seller/view_model/my_ad_provider.dart';
import 'package:local/view/seller/view_model/seller_parent_screen_provider.dart';
import '../../modelview/auth/forget_pass_provider/forget_pass_provider.dart';
import '../../modelview/auth/login_provider/login_screen_provider.dart';
import '../../modelview/auth/signup_provider/sign_up_screen_provider.dart';
import '../../view/seller/view/message/modal_view/chat_screen_provider.dart';
import '../../modelview/disable_account/disable_account.dart';
import '../../modelview/favorite/favorite_provider.dart';
import '../../modelview/home/get_all_post_screen_provider.dart';
import '../../modelview/home/home_category_provider.dart';
import '../../modelview/home/service_detail_provider.dart';
import '../../modelview/home/sub_category_provider.dart';
import '../../view/seller/view/message/modal_view/chat_user_provider.dart';
import '../../view/seller/view_model/seller_provider.dart';
import 'password_visibility_provider.dart';

class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<SellerParentScreenProvider>(
        create: (context) => SellerParentScreenProvider(),
      ),
      ChangeNotifierProvider<ReportPostProvider>(
        create: (context) => ReportPostProvider(),
      ),
      ChangeNotifierProvider<BuyerParentScreenProvider>(
        create: (context) => BuyerParentScreenProvider(),
      ),
      ChangeNotifierProvider<MyAdProvider>(create: (context) => MyAdProvider()),
      ChangeNotifierProvider<ReportPostProvider>(
        create: (context) => ReportPostProvider(),
      ),
      ChangeNotifierProvider<ServiceDetailProvider>(
        create: (context) => ServiceDetailProvider(),
      ),
      ChangeNotifierProvider<PasswordVisibilityProvider>(
        create: (context) => PasswordVisibilityProvider(),
      ),
      ChangeNotifierProvider<SignUpProvider>(
        create: (context) => SignUpProvider(),
      ),
      ChangeNotifierProvider<ForgotPasswordProvider>(
        create: (context) => ForgotPasswordProvider(),
      ),
      ChangeNotifierProvider<SetPasswordProvider>(
        create: (context) => SetPasswordProvider(),
      ),
      ChangeNotifierProvider<LocationProvider>(
        create: (context) => LocationProvider(),
      ),
      ChangeNotifierProvider<ChatUserProvider>(
        create: (context) => ChatUserProvider(),
      ),
      ChangeNotifierProvider<ChatResponseProvider>(
        create: (context) => ChatResponseProvider(),
      ),
      ChangeNotifierProvider<PostViewmodel>(
        create: (context) => PostViewmodel(),
      ),
      ChangeNotifierProvider<SellerProvider>(
        create: (context) => SellerProvider(),
      ),
      ChangeNotifierProvider<PasswordVisibilityProvider>(
        create: (context) => PasswordVisibilityProvider(),
      ),
      ChangeNotifierProvider<SignUpScreenProvider>(
        create: (context) => SignUpScreenProvider(),
      ),
      ChangeNotifierProvider<LoginScreenProvider>(
        create: (context) => LoginScreenProvider(),
      ),
      ChangeNotifierProvider<GetAllPostScreenProvider>(
        create: (context) => GetAllPostScreenProvider(),
      ),
      ChangeNotifierProvider<HomeCategoryProvider>(
        create: (context) => HomeCategoryProvider(),
      ),
      ChangeNotifierProvider<CategoryProvider>(
        create: (context) => CategoryProvider(),
      ),
      ChangeNotifierProvider<ChatScreenProviderSeller>(
        create: (context) => ChatScreenProviderSeller(),
      ),
      ChangeNotifierProvider<ResetPassOtpProvider>(
        create: (context) => ResetPassOtpProvider(),
      ),
      ChangeNotifierProvider<AccountProvider>(
        create: (context) => AccountProvider(),
      ),
      ChangeNotifierProvider<SubCategoryProvider>(
        create: (context) => SubCategoryProvider(),
      ),
      ChangeNotifierProvider<FavoriteProvider>(
        create: (context) => FavoriteProvider(),
      ),
      ChangeNotifierProvider<MyPostDetailsProvider>(
        create: (context) => MyPostDetailsProvider(),
      ),
      ChangeNotifierProvider<EditProfileProvider>(
        create: (context) => EditProfileProvider(),
      ),
      ChangeNotifierProvider<GetPostByCategoryProvider>(
        create: (context) => GetPostByCategoryProvider(),
      ),
      ChangeNotifierProvider<EditPostProvider>(
        create: (context) => EditPostProvider(),
      ),
    ];
  }
}
