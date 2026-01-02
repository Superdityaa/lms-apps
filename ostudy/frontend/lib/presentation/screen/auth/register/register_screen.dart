import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostudy/data/controller/auth/register_controller.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmedPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (passwordController.text != confirmedPasswordController.text) {
      Get.snackbar(
        'Error',
        'Password does not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    registerController.register(
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: GradientColors.lightGradientRevert,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  "Create an account",
                  style: HeadingBold.heading4,
                ),
                const SizedBox(height: 8),
                Text(
                  "Create Your Account to Begin a Personalized Learning Experience.",
                  style: ParagraphBody.smallRegular,
                ),
                const SizedBox(height: 32),
                Text(
                  "Username",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'John Doe',
                  controller: usernameController,
                ),
                Text(
                  "Email",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'Ex : Johndoe@gmail.com',
                  controller: emailController,
                ),
                const SizedBox(height: 8),
                Text(
                  "Password",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'Type Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 8),
                Text(
                  "Re-type Password",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'Re-type Password',
                  isPassword: true,
                  controller: confirmedPasswordController,
                ),
                const SizedBox(height: 8),
                Text(
                  "By signing up you agree to our Term of Use and Privacy Policy",
                  style: ParagraphBody.smallRegular,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => MainButton(
                    color: AppColors.orange500,
                    width: double.infinity,
                    height: 56,
                    text: registerController.isLoading.value
                        ? "Loading..."
                        : "Sign Up",
                    textColor: NeutralColors.white,
                    onPressed: () {
                      if (registerController.isLoading.value) return;
                      _onRegister();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        color: NeutralColors.black50,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR', style: ParagraphBody.smallRegular),
                    ),
                    const Expanded(
                      child: Divider(
                        color: NeutralColors.black50,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomOutlinedButton(
                  text: "Sign up with Google",
                  icon: SvgPicture.asset(
                    'assets/icon/google.svg',
                    width: 20,
                    height: 20,
                  ),
                  color: NeutralColors.black50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account?  ",
                      style: ParagraphBody.smallRegular,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextAuth.paragraphSmallOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
