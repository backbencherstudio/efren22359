class CategoryConversationMetaData {
  bool? success;
  String? message;
  List<Data>? data;

  CategoryConversationMetaData({this.success, this.message, this.data});

  CategoryConversationMetaData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? iCount;
  String? type;

  Data({this.iCount, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    iCount = json['_count'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_count'] = this.iCount;
    data['type'] = this.type;
    return data;
  }
}
