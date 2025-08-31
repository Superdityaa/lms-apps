import 'user_model.dart';

class LoginResponse {
  final String message;
  final String role;
  final String token;
  final UserModel user;

  LoginResponse({
    required this.message,
    required this.role,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      role: json['role'] ?? '',
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'role': role,
      'token': token,
      'user': user.toJson(),
    };
  }
}
