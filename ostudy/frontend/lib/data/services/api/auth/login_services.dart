import 'package:dio/dio.dart';
import 'package:ostudy/data/services/model/login_model.dart';

class LoginServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/api'));

  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.data != null) {
        return LoginResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }
}
