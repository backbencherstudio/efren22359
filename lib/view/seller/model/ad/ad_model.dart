class AdModel {
  final String id;
  final String title;
  final String thumbnail;
  final String category;
  final String username;
  final String location;
  final String? status;
  final String? price;

  AdModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.category,
    required this.username,
    required this.location,
    this.status,
    this.price,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      category: json['category'] ?? json['categoryname'] ?? '',
      username: json['username'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? 'pending',
      price: json['price'],
    );
  }
}
