import 'package:flutter/material.dart';
import 'package:local/cors/constant/app_colors.dart';
import 'package:local/view/seller/view/message/widget/response_message_app_bar.dart';
import 'package:local/view/seller/view/message/widget/response_message_card.dart';
import 'package:provider/provider.dart';

import '../../../../../../cors/routes/routes_name.dart';
import '../../modal_view/chat_response_provider.dart';
import '../../modal_view/chat_user_provider.dart';

class ResponseMessageScreen extends StatelessWidget {
  const ResponseMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ResponseMessageAppBar(),
              Expanded(
                child: Consumer<ChatUserProvider>(
                  builder: (_, userProvider, __) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: userProvider.unblockedUsersCount,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            userProvider.setSelectedUser(
                              userProvider.unblockedUserList[index],
                            );
                            Provider.of<ChatResponseProvider>(context, listen: false).setIsResponseChatRoom(true);
                            Navigator.pushNamed(
                              context,
                              RouteName.chatRoomScreen,
                            );
                          },
                          child: ResponseMessageCard(index: index),
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
