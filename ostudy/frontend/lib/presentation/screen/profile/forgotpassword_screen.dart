import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/profile/profile_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: NeutralColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              CustomPageTitle(
                title: "Forgot Password",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                "We will send the OTP code to your email for security in forgetting your password",
                style: ParagraphBody.mediumRegular,
              ),
              SizedBox(height: size.height * 0.04),
              CustomFormInput(
                height: 56,
                width: double.infinity,
                hintText: 'Ex : Johndoe@gmail.com',
                controller: emailController,
              ),
              SizedBox(height: size.height * 0.55),
              MainButton(
                  text: "Send",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    );
                  },
                  width: 400,
                  height: 50,
                  color: AppColors.orange500,
                  textColor: NeutralColors.white),
            ],
          ),
        ),
      ),
    );
  }
}
