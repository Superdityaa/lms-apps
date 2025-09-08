import 'package:dio/dio.dart';
import 'package:ostudy/data/services/model/mentor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://localhost:8080/api"));

  Future<MentorModel?> getMentorProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final userId = prefs.getString("userId");

    if (token == null || userId == null) return null;

    try {
      final response = await _dio.get(
        "/getMentor/$userId",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        return MentorModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error getMentorProfile: $e");
    }
    return null;
  }

  Future<List<MentorModel>> getAllMentors() async {
    try {
      final response = await _dio.get("/mentors");
      if (response.statusCode == 200) {
        return MentorModel.listFromJson(response.toString());
      }
    } catch (e) {
      print("Error getAllMentors: $e");
    }
    return [];
  }
}
