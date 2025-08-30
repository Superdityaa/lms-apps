import 'dart:convert';

class UserModel {
  final String id;
  final String avatar;
  final String username;
  final String email;
  final String password;
  final String completename;
  final String address;
  final String role;

  UserModel({
    required this.id,
    required this.avatar,
    required this.username,
    required this.email,
    required this.password,
    required this.completename,
    required this.address,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      avatar: json['avatar'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      completename: json['completename'] ?? '',
      address: json['address'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'username': username,
      'email': email,
      'password': password,
      'completename': completename,
      'address': address,
      'role': role,
    };
  }

  static List<UserModel> listFromJson(String str) {
    final data = json.decode(str) as List<dynamic>;
    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}
