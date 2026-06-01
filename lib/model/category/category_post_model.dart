class CategoryPostModel {
  final String id;
  final String type;
  final String title;
  final String thumbnail;
  final String location;
  final String price;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userEmail;

  CategoryPostModel({
    required this.id,
    required this.type,
    required this.title,
    required this.thumbnail,
    required this.location,
    required this.price,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  factory CategoryPostModel.fromJson(Map<String, dynamic> json) {
    return CategoryPostModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      location: json['location'] as String,
      price: json['price'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      userEmail: json['user_email'] as String,
    );
  }
}
