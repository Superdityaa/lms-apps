import 'package:get/get.dart';
import 'package:ostudy/data/services/api/auth/login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginServices _loginServices = LoginServices();
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final loginResponse = await _loginServices.login(email, password);

    if (loginResponse != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', loginResponse.token);
      await prefs.setString('role', loginResponse.role);
      await prefs.setString('user', loginResponse.user.toJson().toString());

      Get.snackbar('Success', 'Welcome ${loginResponse.user.email}');
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Login failed!');
    }

    isLoading.value = false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed('/login');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
