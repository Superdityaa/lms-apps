import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      TransitionPage(page: page),
    );
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
                const SizedBox(height: 16),
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
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 64),
                CustomOutlinedButton(
                  text: "Login with Google",
                  color: NeutralColors.black50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
