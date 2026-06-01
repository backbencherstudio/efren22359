class AllPostModel {
  String? id;
  String? type;
  String? title;
  String? thumbnail;
  String? location;
  String? price;
  String? createdAt;
  User? user;
  Category? category;

  AllPostModel(
      {this.id,
        this.type,
        this.title,
        this.thumbnail,
        this.location,
        this.price,
        this.createdAt,
        this.user,
        this.category});

  AllPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    location = json['location'];
    price = json['price'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['location'] = this.location;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
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

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
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
