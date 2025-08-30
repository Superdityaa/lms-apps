import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ostudy/data/services/model/user_model.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  final Dio _dio = Dio();

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      final response = await _dio.get("http://localhost:8080/api/users");

      if (response.statusCode == 200) {
        users.value = (response.data as List)
            .map((json) => UserModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
