class FavoriteResponse {
  final String message;

  FavoriteResponse({required this.message});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
