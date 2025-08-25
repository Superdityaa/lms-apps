import 'package:dio/dio.dart';

class RegisterServices {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://localhost:8080/api/register'));

  Future<String?> register(
      String username, String email, String password) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
