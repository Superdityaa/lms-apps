import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:ostudy/data/services/api/auth/api_client.dart';
import 'package:ostudy/data/services/api/auth/login_services.dart';
import 'package:ostudy/data/services/model/login_model.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var fieldError = ''.obs;

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    fieldError.value = '';

    try {
      final loginResponse = await _loginService.login(email, password);

      if (loginResponse != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.token);
        await prefs.setString('role', loginResponse.role);
        await prefs.setString('user', loginResponse.user.toJsonString());

        _apiClient.setAuthToken(loginResponse.token);
        return true;
      }

      // Fallback Error Handler
      fieldError.value = 'Wrong email or password';
      return false;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        fieldError.value = 'Wrong email or password';
        return false;
      }

      String message = 'Connection error. Please check your internet.';

      if (e.type == DioExceptionType.connectionTimeout) {
        message = 'Connection timeout. Please try again.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        message = 'Server response timeout. Please try again.';
      } else if (e.response?.statusCode == 500) {
        message = 'Server error. Please try again later.';
      }

      errorMessage.value = message;

      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        backgroundColor: ErrorColors.red100,
        colorText: NeutralColors.white,
        duration: const Duration(seconds: 2),
      );

      return false;
    } catch (_) {
      errorMessage.value = 'Unexpected error occurred';

      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        backgroundColor: ErrorColors.red100,
        colorText: NeutralColors.white,
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
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

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString != null) {
      return User.fromJsonString(userString);
    }
    return null;
  }
}
