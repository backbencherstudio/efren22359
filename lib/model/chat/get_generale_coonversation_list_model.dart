class GeneraleConversationListModel {
  bool? success;
  String? message;
  List<Data>? data;

  GeneraleConversationListModel({this.success, this.message, this.data});

  GeneraleConversationListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? creatorId;
  String? participantId;
  String? createdAt;
  String? updatedAt;
  Null? type;
  bool? blockedByCreator;
  bool? blockedByParticipant;
  Null? post;
  Creator? creator;
  Creator? participant;
  String? conversationType;
  LastMessage? lastMessage;

  Data(
      {this.id,
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
        this.lastMessage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    participantId = json['participant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    blockedByCreator = json['blocked_by_creator'];
    blockedByParticipant = json['blocked_by_participant'];
    post = json['post'];
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    participant = json['participant'] != null
        ? new Creator.fromJson(json['participant'])
        : null;
    conversationType = json['conversation_type'];
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator_id'] = this.creatorId;
    data['participant_id'] = this.participantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['blocked_by_creator'] = this.blockedByCreator;
    data['blocked_by_participant'] = this.blockedByParticipant;
    data['post'] = this.post;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    if (this.participant != null) {
      data['participant'] = this.participant!.toJson();
    }
    data['conversation_type'] = this.conversationType;
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    return data;
  }
}

class Creator {
  String? id;
  String? name;
  String? avatar;
  String? availability;
  String? lastAvailabilityAt;
  String? avatarUrl;

  Creator(
      {this.id,
        this.name,
        this.avatar,
        this.availability,
        this.lastAvailabilityAt,
        this.avatarUrl});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    availability = json['availability'];
    lastAvailabilityAt = json['last_availability_at'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['availability'] = this.availability;
    data['last_availability_at'] = this.lastAvailabilityAt;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}

class LastMessage {
  String? id;
  String? message;
  String? createdAt;
  String? senderId;
  bool? isRead;

  LastMessage(
      {this.id, this.message, this.createdAt, this.senderId, this.isRead});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
    senderId = json['sender_id'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['sender_id'] = this.senderId;
    data['is_read'] = this.isRead;
    return data;
  }
}
