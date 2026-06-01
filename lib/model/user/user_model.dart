class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? address;
  final String? phoneNumber;
  final String? type;
  final String? gender;
  final DateTime? dateOfBirth;
  final List<String> experience;
  final String? about;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.address,
    this.phoneNumber,
    this.type,
    this.gender,
    this.dateOfBirth,
    this.experience = const [],
    this.about,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      type: json['type'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'])
          : null,
      experience: (json['experience'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      about: json['about'],
    );
  }
}
