import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ostudy/data/services/api/auth/api_client.dart';
import 'package:ostudy/data/services/api/auth/login_services.dart';
import 'package:ostudy/data/services/model/login_model.dart';
import 'package:ostudy/presentation/screen/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final loginResponse = await _loginService.login(email, password);

      if (loginResponse != null) {
        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.token);
        await prefs.setString('role', loginResponse.role);
        await prefs.setString('user', loginResponse.user.toJsonString());

        _apiClient.setAuthToken(loginResponse.token);

        Get.offAll(() => const Profile());

        return true;
      } else {
        errorMessage.value = 'Login failed. Please check your credentials.';
        Get.snackbar(
          'Login Failed',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
        return false;
      }
    } on DioException catch (e) {
      String message = 'Connection error. Please check your internet.';

      if (e.type == DioExceptionType.connectionTimeout) {
        message = 'Connection timeout. Please try again.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        message = 'Server response timeout. Please try again.';
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          message = 'Invalid email or password.';
        } else if (statusCode == 500) {
          message = 'Server error. Please try again later.';
        } else {
          message = e.response?.data['error'] ?? 'Login failed.';
        }
      }

      errorMessage.value = message;
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
      return false;
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('user');
    _apiClient.removeAuthToken();
    Get.offAllNamed('/login');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      _apiClient.setAuthToken(token);
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      return User.fromJsonString(userString);
    }
    return null;
  }
}
