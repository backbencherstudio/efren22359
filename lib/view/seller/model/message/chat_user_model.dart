class ChatUserModel {
  final String id;
  final String name;
  final String photoUrl;
  final bool isOnline;
  bool isBlocked;
  final bool lastMessageSeen;
  final String lastMessage;
  final DateTime lastMessageTime;
  final DateTime lastActive;

  ChatUserModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.isOnline,
    this.isBlocked = false,
    required this.lastMessageSeen,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastActive,
  });
}