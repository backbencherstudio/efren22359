import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../cors/constant/app_icons.dart';
import '../../../../../cors/utils/custom_chat_room_bottom_sheet.dart';
import '../../../model/message/chat_user_model.dart';
import '../modal_view/chat_user_provider.dart';

class ChatRoomScreenAppBar extends StatelessWidget {
  const ChatRoomScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ChatUserModel? userModel = Provider.of<ChatUserProvider>(context).selectedUser;
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios_new),
            ),
            Expanded(
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(userModel!.photoUrl),
                ),
                title: Text(userModel.name),
              ),
            ),
            GestureDetector(
              onTap: (){CustomChatRoomBottomSheet.showMenuBottomSheet(context: context, userModel: userModel);},
              child: Image.asset(AppIcons.moreHorizIcon, scale: 1.5),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Divider(),
      ],
    );
  }
}