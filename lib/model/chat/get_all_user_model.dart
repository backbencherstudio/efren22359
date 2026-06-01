class AllUserModel {
  bool? success;
  List<Data>? data;

  AllUserModel({this.success, this.data});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? fullName;
  String? type;

  Data({this.id, this.email, this.fullName, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['type'] = this.type;
    return data;
  }
}
