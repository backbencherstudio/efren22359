import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local/cors/utils/block_toggle_bottom_sheet.dart';
import 'package:local/view/seller/view/message/widget/block_user_screen_app_bar.dart';
import 'package:provider/provider.dart';

import '../../modal_view/chat_user_provider.dart';

class BlockUserScreen extends StatelessWidget {
  const BlockUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              BlockUserScreenAppBar(),
              SizedBox(height: 20.h),
              Expanded(
                child: Consumer<ChatUserProvider>(
                  builder: (context, userProvider, child) {
                    return ListView.separated(
                      itemCount: userProvider.blockedUsersCount,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(userProvider.blockedUserList[index].photoUrl),
                          title: Text(userProvider.blockedUserList[index].name),
                          trailing: SizedBox(
                            height: 30.h,
                            child: OutlinedButton(
                              onPressed: () {
                                BlockToggleBottomSheet.showMenuBottomSheet(
                                  context: context,
                                  name: userProvider.blockedUserList[index].name,
                                  userId: userProvider.blockedUserList[index].id,
                                  isBlocking: false,
                                  provider: userProvider,
                                );
                              },
                              style: OutlinedButton.styleFrom(side: BorderSide(width: 2, color: const Color(0xffD2D2D5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r),),),
                              child: Text('Unblock'),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
