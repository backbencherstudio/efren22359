class UserProfileDataModel {
  bool? success;
  Data? data;

  UserProfileDataModel({this.success, this.data});

  UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Data {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? avatarUrl;
  String? type;
  String? address;
  String? country;
  String? city;
  String? state;
  String? bio;
  List<dynamic>? experience; // ✅ Fixed type
  String? phoneNumber;
  String? gender;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.avatarUrl,
    this.type,
    this.address,
    this.country,
    this.city,
    this.state,
    this.bio,
    this.experience,
    this.phoneNumber,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    avatarUrl = json['avatar_url'];
    type = json['type'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    bio = json['bio'];
    // ✅ Safely parse experience
    if (json['experience'] != null) {
      if (json['experience'] is List) {
        experience = List<dynamic>.from(json['experience']);
      } else {
        experience = [];
      }
    } else {
      experience = [];
    }
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['avatar'] = avatar;
    map['avatar_url'] = avatarUrl;
    map['type'] = type;
    map['address'] = address;
    map['country'] = country;
    map['city'] = city;
    map['state'] = state;
    map['bio'] = bio;
    map['experience'] = experience;
    map['phone_number'] = phoneNumber;
    map['gender'] = gender;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
