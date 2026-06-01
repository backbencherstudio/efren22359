// conversation_detail_model.dart

class ConversationDetailModel {
  bool? success;
  String? message;
  Data? data;

  ConversationDetailModel({this.success, this.message, this.data});

  ConversationDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

class Data {
  String? id;
  String? creatorId;
  String? participantId;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? conversationType;
  bool? blockedByCreator;
  bool? blockedByParticipant;
  Post? post;
  Creator? creator;
  Creator? participant;
  LastMessage? lastMessage;

  Data({
    this.id,
    this.creatorId,
    this.participantId,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.conversationType,
    this.blockedByCreator,
    this.blockedByParticipant,
    this.post,
    this.creator,
    this.participant,
    this.lastMessage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    creatorId = json['creator_id']?.toString();
    participantId = json['participant_id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();

    // type can be string or object sometimes — coerce to string safely
    type = json['type'] is String ? json['type'] : json['type']?.toString();

    conversationType =
    json['conversation_type'] is String ? json['conversation_type'] : json['conversation_type']?.toString();

    blockedByCreator = json['blocked_by_creator'] is bool ? json['blocked_by_creator'] : (json['blocked_by_creator'] == 1);
    blockedByParticipant = json['blocked_by_participant'] is bool ? json['blocked_by_participant'] : (json['blocked_by_participant'] == 1);

    // Post: can be null or an object
    post = json['post'] != null && json['post'] is Map<String, dynamic> ? Post.fromJson(Map<String, dynamic>.from(json['post'])) : null;

    creator = json['creator'] != null && json['creator'] is Map<String, dynamic>
        ? Creator.fromJson(Map<String, dynamic>.from(json['creator']))
        : null;

    participant = json['participant'] != null && json['participant'] is Map<String, dynamic>
        ? Creator.fromJson(Map<String, dynamic>.from(json['participant']))
        : null;

    lastMessage = json['last_message'] != null && json['last_message'] is Map<String, dynamic>
        ? LastMessage.fromJson(Map<String, dynamic>.from(json['last_message']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['creator_id'] = creatorId;
    map['participant_id'] = participantId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['type'] = type;
    map['conversation_type'] = conversationType;
    map['blocked_by_creator'] = blockedByCreator;
    map['blocked_by_participant'] = blockedByParticipant;
    map['post'] = post?.toJson();
    if (creator != null) map['creator'] = creator!.toJson();
    if (participant != null) map['participant'] = participant!.toJson();
    if (lastMessage != null) map['last_message'] = lastMessage!.toJson();
    return map;
  }
}

class Post {
  String? id;
  String? title;
  String? type;

  Post({this.id, this.title, this.type});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    type = json['type']?.toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    return map;
  }
}

class Creator {
  String? id;
  String? name;
  String? avatar; // String? (URL or filename)
  String? availability;
  String? lastAvailabilityAt;

  Creator({
    this.id,
    this.name,
    this.avatar,
    this.availability,
    this.lastAvailabilityAt,
  });

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();

    // avatar might be null, empty, a string, or even an object — handle safely
    if (json['avatar'] == null) {
      avatar = null;
    } else if (json['avatar'] is String) {
      avatar = json['avatar'];
    } else {
      // if server returns map/object for avatar, try to extract url or convert to string
      try {
        avatar = json['avatar'].toString();
      } catch (_) {
        avatar = null;
      }
    }

    availability = json['availability']?.toString();
    lastAvailabilityAt = json['last_availability_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    map['availability'] = availability;
    map['last_availability_at'] = lastAvailabilityAt;
    return map;
  }
}

class LastMessage {
  String? id;
  String? message;
  String? createdAt;
  String? senderId;
  bool? isRead;
  List<Attachments>? attachments;

  LastMessage({
    this.id,
    this.message,
    this.createdAt,
    this.senderId,
    this.isRead,
    this.attachments,
  });

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    message = json['message']?.toString();
    createdAt = json['created_at']?.toString();
    senderId = json['sender_id']?.toString();
    isRead = json['is_read'] is bool ? json['is_read'] : (json['is_read'] == 1);

    if (json['attachments'] != null && json['attachments'] is List) {
      attachments = <Attachments>[];
      for (var v in json['attachments']) {
        if (v is Map<String, dynamic>) {
          attachments!.add(Attachments.fromJson(Map<String, dynamic>.from(v)));
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['created_at'] = createdAt;
    map['sender_id'] = senderId;
    map['is_read'] = isRead;
    if (attachments != null) {
      map['attachments'] = attachments!.map((e) => e.toJson()).toList();
    }
    return map;
  }
}

class Attachments {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt; // changed from Null? to String?
  String? name;
  String? type;
  int? size;
  String? file;
  String? fileAlt; // changed from Null? to String?
  String? messageId;

  Attachments({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.type,
    this.size,
    this.file,
    this.fileAlt,
    this.messageId,
  });

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
    name = json['name']?.toString();
    type = json['type']?.toString();
    // size might be int or string -> try parse
    if (json['size'] is int) {
      size = json['size'];
    } else if (json['size'] is String) {
      size = int.tryParse(json['size']);
    } else {
      size = null;
    }
    file = json['file']?.toString();
    fileAlt = json['file_alt']?.toString();
    messageId = json['message_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['name'] = name;
    map['type'] = type;
    map['size'] = size;
    map['file'] = file;
    map['file_alt'] = fileAlt;
    map['message_id'] = messageId;
    return map;
  }
}
