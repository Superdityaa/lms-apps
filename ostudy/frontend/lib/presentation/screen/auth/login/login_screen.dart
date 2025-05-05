import 'package:flutter/material.dart';
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

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: GradientColors.lightGradientRevert,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32, top: 72),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/onboarding1.png',
                width: size.width * 0.5,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Text(
                "Welcome Back!",
                style: HeadingBold.heading4,
              ),
              const SizedBox(height: 24),
              Text(
                "Sign in to Continue Your Learning Journey and Access Your Personalized Courses and Progress.",
                style: ParagraphBody.smallRegular,
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Text("Email or Username", style: ParagraphBody.mediumBold,),
                  const SizedBox(height: 8)
                  
                ],
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Text("Password", style: ParagraphBody.mediumBold,),
                  const SizedBox(height: 8)
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
