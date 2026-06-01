import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local/view/seller/view/message/modal_view/chat_user_provider.dart';
import 'package:provider/provider.dart';

class ResponseMessageCard extends StatelessWidget {
  const ResponseMessageCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final unblockedUserList = Provider.of<ChatUserProvider>(context).unblockedUserList;
    return ListTile(
      leading: Image.asset(unblockedUserList[index].photoUrl),
      title: Text(unblockedUserList[index].name, style: TextStyle(fontWeight: unblockedUserList[index].lastMessageSeen ? FontWeight.w400 : FontWeight.w600)),
      subtitle: Text(unblockedUserList[index].lastMessage, style: TextStyle(fontWeight: unblockedUserList[index].lastMessageSeen ? FontWeight.w400 : FontWeight.w600),),
      trailing: Text(DateFormat('MMM dd').format(unblockedUserList[index].lastMessageTime)),
    );
  }
}