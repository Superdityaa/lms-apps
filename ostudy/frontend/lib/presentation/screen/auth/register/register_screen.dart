import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_transition.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      TransitionPage(page: page),
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
                const CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'John Doe',
                ),
                Text(
                  "Email",
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
                const SizedBox(height: 8),
                Text(
                  "Re-type Password",
                  style: ParagraphBody.mediumBold,
                ),
                const SizedBox(height: 8),
                const CustomFormInput(
                  height: 56,
                  width: double.infinity,
                  hintText: 'Re-type Password',
                  isPassword: true,
                ),
                const SizedBox(height: 8),
                Text(
                  "By signing up you agree to our Term of Use and Privacy Policy",
                  style: ParagraphBody.smallRegular,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                MainButton(
                  color: AppColors.orange500,
                  width: double.infinity,
                  height: 56,
                  text: "Sign Up",
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
