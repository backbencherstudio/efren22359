enum MessageType { text, image, video }

enum MessageStatus { sent, read }

class MessageModel {
  final String content;
  final DateTime timestamp;
  final bool isCurrentUser;
  final bool showTimestamp;

  MessageModel({
    required this.content,
    required this.timestamp,
    required this.isCurrentUser,
    required this.showTimestamp
  });
}


// class ChatMessageModel {
//   final String id;
//   final String chatRoomId;
//   final String senderId;
//   final String receiverId;
//   final String content;
//   final MessageType type;
//   final MessageStatus status;
//   final DateTime timestamp;
//   final List<String> readBy;
//
//   ChatMessageModel({
//     required this.id,
//     required this.chatRoomId,
//     required this.senderId,
//     required this.receiverId,
//     required this.content,
//     this.type = MessageType.text,
//     this.status = MessageStatus.sent,
//     required this.timestamp,
//     required this.readBy,
//   });
// }