class GetConversationMetadata {
  bool? success;
  String? message;
  Data? data;

  GetConversationMetadata({this.success, this.message, this.data});

  GetConversationMetadata.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['success'] = success;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class Data {
  int? generals;
  int? adResponses;

  Data({this.generals, this.adResponses});

  Data.fromJson(Map<String, dynamic> json) {
    generals = json['generals'];
    adResponses = json['adResponses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['generals'] = generals;
    result['adResponses'] = adResponses;
    return result;
  }

  operator [](int other) {}
}
