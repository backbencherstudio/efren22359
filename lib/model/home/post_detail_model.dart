
class PostDetailModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? status;
  String? type;
  String? title;
  String? description;
  String? thumbnail;
  List<String>? tags;
  String? price;
  dynamic salaryRange;
  dynamic salaryType;
  String? location;
  String? categoryId;
  String? userId;
  dynamic username;
  String? expiresAt;
  String? expiresDate;
  bool? allowChatOnly;
  bool? showChatInfo;
  bool? isAccepted;
  dynamic rejectedAt;
  dynamic rejectedReason;
  bool? isPaused;
  dynamic pausedAt;
  dynamic pausedReason;
  int? isReported;
  dynamic reportedAt;
  User? user;
  Category? category;

  PostDetailModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.status,
        this.type,
        this.title,
        this.description,
        this.thumbnail,
        this.tags,
        this.price,
        this.salaryRange,
        this.salaryType,
        this.location,
        this.categoryId,
        this.userId,
        this.username,
        this.expiresAt,
        this.expiresDate,
        this.allowChatOnly,
        this.showChatInfo,
        this.isAccepted,
        this.rejectedAt,
        this.rejectedReason,
        this.isPaused,
        this.pausedAt,
        this.pausedReason,
        this.isReported,
        this.reportedAt,
        this.user,
        this.category});

  PostDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    status = json['status'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    tags = json['tags'].cast<String>();
    price = json['price'];
    salaryRange = json['salary_range'];
    salaryType = json['salary_type'];
    location = json['location'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    username = json['username'];
    expiresAt = json['expires_at'];
    expiresDate = json['expires_date'];
    allowChatOnly = json['allow_chat_only'];
    showChatInfo = json['show_chat_info'];
    isAccepted = json['is_accepted'];
    rejectedAt = json['rejected_at'];
    rejectedReason = json['rejected_reason'];
    isPaused = json['is_paused'];
    pausedAt = json['paused_at'];
    pausedReason = json['paused_reason'];
    isReported = json['is_reported'];
    reportedAt = json['reported_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['status'] = this.status;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['tags'] = this.tags;
    data['price'] = this.price;
    data['salary_range'] = this.salaryRange;
    data['salary_type'] = this.salaryType;
    data['location'] = this.location;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['expires_at'] = this.expiresAt;
    data['expires_date'] = this.expiresDate;
    data['allow_chat_only'] = this.allowChatOnly;
    data['show_chat_info'] = this.showChatInfo;
    data['is_accepted'] = this.isAccepted;
    data['rejected_at'] = this.rejectedAt;
    data['rejected_reason'] = this.rejectedReason;
    data['is_paused'] = this.isPaused;
    data['paused_at'] = this.pausedAt;
    data['paused_reason'] = this.pausedReason;
    data['is_reported'] = this.isReported;
    data['reported_at'] = this.reportedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? phone;

  User({this.id, this.name, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Category {
  String? id;
  String? title;
  String? parentId;

  Category({this.id, this.title, this.parentId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['parent_id'] = this.parentId;
    return data;
  }
}
