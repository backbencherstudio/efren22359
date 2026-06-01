class SubCategoryModel {
  final String id;
  final String parent_id;
  final String parent_name;
  final String title;
  final String slug;
  final int? conversation_count;

  SubCategoryModel({
    required this.id,
    required this.parent_id,
    required this.parent_name,
    required this.title,
    required this.slug,
    this.conversation_count,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      parent_id: json['parent_id'],
      parent_name: json['parent_name'],
      title: json['title'],
      slug: json['slug'],
      conversation_count: json['conversation_count'] ?? 0,
    );
  }
}