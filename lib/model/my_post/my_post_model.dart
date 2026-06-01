class MyPostModel {
  final String id;
  final String type;
  final String title;
  final String thumbnail;
  final String location;
  final String status;
  final String price;
  final String postStatus;
  final DateTime createdAt;
  final bool isAccepted;
  final int isReported;
  final String? rejectedAt;
  final String? rejectedReason;
  final String userId;
  final String userName;
  final String userEmail;
  final String categoryId;
  final String categoryTitle;
  final String categoryParentId;

  MyPostModel({
    required this.id,
    required this.type,
    required this.title,
    required this.thumbnail,
    required this.location,
    required this.status,
    required this.price,
    required this.postStatus,
    required this.createdAt,
    required this.isAccepted,
    required this.isReported,
    this.rejectedAt,
    this.rejectedReason,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryParentId,
  });

  factory MyPostModel.fromJson(Map<String, dynamic> json) {
    return MyPostModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? '',
      price: json['price']?.toString() ?? '',
      postStatus: json['post_status'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      isAccepted: json['is_accepted'] ?? false,
      isReported: json['is_reported'] ?? 0,
      rejectedAt: json['rejected_at'],
      rejectedReason: json['rejected_reason'],
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
      userEmail: json['user_email'] ?? '',
      categoryId: json['category_id'] ?? '',
      categoryTitle: json['category_title'] ?? '',
      categoryParentId: json['category_parent_id'] ?? '',
    );
  }
}
