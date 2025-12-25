import 'dart:convert';

class LoginResponse {
  final String message;
  final String token;
  final String role;
  final User user;

  LoginResponse({
    required this.message,
    required this.token,
    required this.role,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      role: json['role'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'role': role,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String completename;
  final String address;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.completename,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      completename: json['completename'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'completename': completename,
      'address': address,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory User.fromJsonString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }
}
