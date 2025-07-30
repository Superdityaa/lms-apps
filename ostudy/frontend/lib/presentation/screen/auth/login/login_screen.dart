import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_transition.dart';
import 'package:ostudy/presentation/screen/auth/register/register_screen.dart';
import 'package:ostudy/presentation/screen/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      TransitionPage(page: page),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                Image.asset(
                  'assets/images/onboarding1.png',
                  width: size.width * 0.4,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                Text(
                  "Welcome Back!",
                  style: HeadingBold.heading4,
                ),
                const SizedBox(height: 16),
                Text(
                  "Sign in to Continue Your Learning Journey and Access Your Personalized Courses and Progress.",
                  style: ParagraphBody.smallRegular,
                ),
                const SizedBox(height: 32),
                Text(
                  "Email or Username",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                const CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'Ex : Johndoe@gmail.com',
                ),
                const SizedBox(height: 8),
                Text(
                  "Password",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                const CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'Type Password',
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                MainButton(
                  color: AppColors.orange500,
                  width: double.infinity,
                  height: 56,
                  text: "Login",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
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
                  text: "Login with Google",
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
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have Account?  ",
                      style: ParagraphBody.smallRegular,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Create Account",
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
