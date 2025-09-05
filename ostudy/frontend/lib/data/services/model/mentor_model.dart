import 'dart:convert';

class MentorModel {
  final String id;
  final String avatar;
  final String name;
  final String email;
  final String role;
  final String description;

  MentorModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.role,
    required this.description,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
        id: json['id'] ?? '',
        avatar: json['avatar'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        role: json['role'] ?? '',
        description: json['description'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'name': name,
      'email': email,
      'role': role,
      'description': description,
    };
  }

  static List<MentorModel> listFromJson(String str) {
    final data = json.decode(str) as List<dynamic>;
    return data.map((json) => MentorModel.fromJson(json)).toList();
  }
}
