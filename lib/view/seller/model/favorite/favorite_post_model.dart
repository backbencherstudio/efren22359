class FavoritePostModel {
  final String favoriteId;
  final String postId;
  final String type;
  final String title;
  final String thumbnail;
  final String location;
  final String price;
  final String userId;
  final String userName;
  final String userEmail;
  final String categoryId;
  final String categoryTitle;
  final String categoryParentId;

  FavoritePostModel({
    required this.favoriteId,
    required this.postId,
    required this.type,
    required this.title,
    required this.thumbnail,
    required this.location,
    required this.price,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryParentId,
  });

  factory FavoritePostModel.fromJson(Map<String, dynamic> json) {
    return FavoritePostModel(
      favoriteId: json['favorite_id'],
      postId: json['post_id'],
      type: json['type'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      location: json['location'],
      price: json['price'],
      userId: json['user_id'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      categoryId: json['category_id'],
      categoryTitle: json['category_title'],
      categoryParentId: json['category_parent_id'],
    );
  }
}