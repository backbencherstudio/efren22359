class PostModel{
  final String category;
  final String subCategory;
  final String title;
  final String location;
  final String price;
  final String createdAgo;
  final String description;
  final List<String> tags;

  PostModel({
    required this.category,
    required this.subCategory,
    required this.title,
    required this.location,
    required this.price,
    required this.createdAgo,
    required this.description,
    required this.tags
  });
}