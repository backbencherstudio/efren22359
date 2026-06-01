import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../modal_view/chat_user_provider.dart';

class ResponseChatRoomAppBar extends StatelessWidget {
  const ResponseChatRoomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new)),
            Expanded(
              child: ListTile(
                title: Text('Po: Graphics Designer', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),),
                subtitle: Text('with ${Provider.of<ChatUserProvider>(context).selectedUser!.name}'),
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Divider(),
      ],
    );
  }
}
