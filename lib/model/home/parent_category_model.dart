class ParentCategoryModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? parentId;
  String? parentName;
  String? title;
  String? slug;

  ParentCategoryModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.parentId,
        this.parentName,
        this.title,
        this.slug});

  ParentCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    parentId = json['parent_id'];
    parentName = json['parent_name'];
    title = json['title'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['parent_id'] = this.parentId;
    data['parent_name'] = this.parentName;
    data['title'] = this.title;
    data['slug'] = this.slug;
    return data;
  }
}
