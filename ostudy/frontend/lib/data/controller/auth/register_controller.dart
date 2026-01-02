import 'package:get/get.dart';
import 'package:ostudy/data/services/api/auth/register_services.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';

class RegisterController extends GetxController {
  final RegisterService _registerService = RegisterService();

  var isLoading = false.obs;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final result = await _registerService.register(
        username: username,
        email: email,
        password: password,
      );

      Get.snackbar(
        'Success',
        result.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
