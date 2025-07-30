import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/api/login'));

  Future<String?> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }
}
