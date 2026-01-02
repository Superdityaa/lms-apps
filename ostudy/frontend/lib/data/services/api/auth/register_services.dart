import 'package:dio/dio.dart';
import 'package:ostudy/data/services/api/auth/api_client.dart';
import 'package:ostudy/data/services/model/register_model.dart';

class RegisterService {
  final ApiClient _apiClient = ApiClient();

  Future<RegisterModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        return RegisterModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );
      }

      throw Exception('Unexpected status code: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        throw Exception(data['error'] ?? 'Register failed');
      }
      throw Exception('Connection error');
    }
  }
}
