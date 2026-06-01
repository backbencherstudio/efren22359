class ChatRoomModel {
  final String id;
  final List<String> participants;
  final String? lastMessage;
  final String? lastMessageSenderId;
  final DateTime? lastMessageTime;
  final Map<String, DateTime>? lastReadTime;
  final Map<String, String>? participantsName;
  final bool isTyping;
  final String? typingUserId;
  final bool isCallActive;

  ChatRoomModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastMessageSenderId,
    this.lastMessageTime,
    Map<String, DateTime>? lastReadTime,
    Map<String, String>? participantsName,
    this.isTyping = false,
    this.typingUserId,
    this.isCallActive = false,
  }) : lastReadTime = lastReadTime ?? {},
       participantsName = participantsName ?? {};
}
