class DisableAccountResponse {
  final bool success;
  final String message;

  DisableAccountResponse({
    required this.success,
    required this.message,
  });

  factory DisableAccountResponse.fromJson(Map<String, dynamic> json) {
    return DisableAccountResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
