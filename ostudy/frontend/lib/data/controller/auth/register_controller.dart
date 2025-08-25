import 'package:get/get.dart';
import 'package:ostudy/data/services/api/auth/register_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final RegisterServices _registerServices = RegisterServices();
  var isLoading = false.obs;

  Future<void> register(String username, String email, String password) async {
    isLoading.value = true;
    final token = await _registerServices.register(username, email, password);

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      Get.snackbar('Success', 'Logged in!');
    } else {
      Get.snackbar('Error', 'Login failed!');
    }

    isLoading.value = false;
  }

  Future<bool> isSuccessRegister() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
