import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/routes/routes_name.dart';
import 'package:local/view/seller/view/message/modal_view/chat_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../cors/constant/app_colors.dart';
import '../../../../../cors/constant/app_icons.dart';

class ChatResponseCard extends StatelessWidget {
  const ChatResponseCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatScreenProviderSeller>(context);
    final categoryData = provider.categoryConversationMetaData?.data?[index];
    if (categoryData == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteName.addResponseListScreen);
        Provider.of<ChatScreenProviderSeller>(
          context,
          listen: false,
        ).getCategoryBasedConversation(categoryData.type ?? '');

        debugPrint("The category type is ${categoryData.type}");
      },
      child: ListTile(
        leading: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColors.fieldColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Image.asset(
            AppIcons.jobIcon,
            color: const Color(0xff1D202C),
            scale: 2,
          ),
        ),
        title: Text(
          categoryData.type ?? 'Unknown',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("${categoryData.iCount ?? 0} conversations"),
      ),
    );
  }
}
