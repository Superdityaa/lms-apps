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
        final data = response.data;

        if (data is Map<String, dynamic>) {
          return RegisterModel.fromJson(data);
        } else {
          throw Exception('Invalid response format');
        }
      }

      throw Exception('Unexpected status code: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic> && data['error'] != null) {
          throw Exception(data['error']);
        }

        throw Exception('Register failed');
      }

      throw Exception('Connection error');
    }
  }
}
