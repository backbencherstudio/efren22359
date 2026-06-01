class CategoryBasedConversation {
  bool? success;
  String? message;
  List<Data>? data;

  CategoryBasedConversation({this.success, this.message, this.data});

  CategoryBasedConversation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
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
  bool? blockedByCreator;
  bool? blockedByParticipant;
  Post? post;
  Creator? creator;
  Creator? participant;
  String? conversationType;
  dynamic lastMessage; // Fixed here (was Null?)

  Data({
    this.id,
    this.creatorId,
    this.participantId,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.blockedByCreator,
    this.blockedByParticipant,
    this.post,
    this.creator,
    this.participant,
    this.conversationType,
    this.lastMessage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    participantId = json['participant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    blockedByCreator = json['blocked_by_creator'];
    blockedByParticipant = json['blocked_by_participant'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    participant =
        json['participant'] != null
            ? Creator.fromJson(json['participant'])
            : null;
    conversationType = json['conversation_type'];

    //  Safe parsing of last_message
    lastMessage = json['last_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['creator_id'] = creatorId;
    map['participant_id'] = participantId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['type'] = type;
    map['blocked_by_creator'] = blockedByCreator;
    map['blocked_by_participant'] = blockedByParticipant;
    if (post != null) map['post'] = post!.toJson();
    if (creator != null) map['creator'] = creator!.toJson();
    if (participant != null) map['participant'] = participant!.toJson();
    map['conversation_type'] = conversationType;
    map['last_message'] = lastMessage;
    return map;
  }
}

class Post {
  String? id;
  String? title;
  String? type;

  Post({this.id, this.title, this.type});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    return map;
  }
}

class Creator {
  String? id;
  String? name;
  dynamic avatar; //  Allow flexibility (can be string or null)
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
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    availability = json['availability'];
    lastAvailabilityAt = json['last_availability_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    map['availability'] = availability;
    map['last_availability_at'] = lastAvailabilityAt;
    return map;
  }
}
