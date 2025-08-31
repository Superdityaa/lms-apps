import 'package:dio/dio.dart';
import 'package:ostudy/data/services/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://localhost:8080/api"));

  Future<UserModel?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final userId = prefs.getString("userId");

    if (token == null || userId == null) return null;

    try {
      final response = await _dio.get(
        "/getUser/$userId",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error getUserProfile: $e");
    }
    return null;
  }
}
