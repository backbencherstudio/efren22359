import 'package:local/view/seller/model/message/message_model.dart';

final List<MessageModel> messages = [
  MessageModel(
    content: "Hello, Doe",
    timestamp: DateTime.now().subtract(Duration(minutes: 60)),
    isCurrentUser: false,
    showTimestamp: true,
  ),
  MessageModel(
    content: "why does my back hurt so much?",
    timestamp: DateTime.now().subtract(Duration(minutes: 59)),
    isCurrentUser: false,
    showTimestamp: false,
  ),
  MessageModel(
    content: "You sit too long. Try drinking lots of water",
    timestamp: DateTime.now().subtract(Duration(minutes: 58)),
    isCurrentUser: true,
    showTimestamp: false,
  ),
  MessageModel(
    content: "Oh like that.",
    timestamp: DateTime.now().subtract(Duration(minutes: 50)),
    isCurrentUser: false,
    showTimestamp: true,
  ),
  MessageModel(
    content: "ok doc. I will drink lots of water and exercise.",
    timestamp: DateTime.now().subtract(Duration(minutes: 49)),
    isCurrentUser: false,
    showTimestamp: false,
  ),
  MessageModel(
    content: "Thanks a lot 😘",
    timestamp: DateTime.now().subtract(Duration(minutes: 48)),
    isCurrentUser: false,
    showTimestamp: false,
  ),
  MessageModel(
    content: "Don't mention it baby ✨",
    timestamp: DateTime.now().subtract(Duration(minutes: 47)),
    isCurrentUser: true,
    showTimestamp: true,
  ),
];
