class MessageDetailModel {
  bool? success;
  String? message;
  Data? data;

  MessageDetailModel({this.success, this.message, this.data});

  MessageDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Messages>? messages;
  Pagination? pagination;

  Data({this.messages, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Messages {
  String? id;
  String? message;
  String? createdAt;
  String? senderId;
  bool? isRead;
  List<Attachments>? attachments;

  Messages(
      {this.id,
        this.message,
        this.createdAt,
        this.senderId,
        this.isRead,
        this.attachments});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
    senderId = json['sender_id'];
    isRead = json['is_read'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['sender_id'] = this.senderId;
    data['is_read'] = this.isRead;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  String? id;
  String? file;
  Null? fileAlt;
  String? fileUrl;

  Attachments({this.id, this.file, this.fileAlt, this.fileUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    fileAlt = json['file_alt'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['file_alt'] = this.fileAlt;
    data['file_url'] = this.fileUrl;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? pageSize;
  int? totalItems;
  int? totalPages;
  bool? hasNext;
  bool? hasPrev;

  Pagination(
      {this.currentPage,
        this.pageSize,
        this.totalItems,
        this.totalPages,
        this.hasNext,
        this.hasPrev});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    pageSize = json['page_size'];
    totalItems = json['total_items'];
    totalPages = json['total_pages'];
    hasNext = json['has_next'];
    hasPrev = json['has_prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['page_size'] = this.pageSize;
    data['total_items'] = this.totalItems;
    data['total_pages'] = this.totalPages;
    data['has_next'] = this.hasNext;
    data['has_prev'] = this.hasPrev;
    return data;
  }
}
