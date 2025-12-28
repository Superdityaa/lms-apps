import 'package:dio/dio.dart';
import 'package:ostudy/data/services/api/auth/api_client.dart';
import 'package:ostudy/data/services/model/login_model.dart';

class LoginService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return LoginResponse.fromJson(response.data);
      }

      return null;
    } on DioException {
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // Future<bool> register(Map<String, dynamic> payload) async {
  //   try {
  //     final response = await _apiClient.dio.post('/register', data: payload);
  //     return response.statusCode == 200 || response.statusCode == 201;
  //   } catch (e) {
  //     print('Register error: $e');
  //     return false;
  //   }
  // }

  // Future<bool> forgotPassword(String email) async {
  //   try {
  //     final response = await _apiClient.dio.post(
  //       '/forgot-password',
  //       data: {'email': email},
  //     );
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print('Forgot password error: $e');
  //     return false;
  //   }
  // }

  // Future<bool> resetPassword(String token, String newPassword) async {
  //   try {
  //     final response = await _apiClient.dio.post(
  //       '/reset-password',
  //       data: {
  //         'token': token,
  //         'password': newPassword,
  //       },
  //     );
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print('Reset password error: $e');
  //     return false;
  //   }
  // }
}
