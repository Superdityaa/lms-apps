import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/courses/detail_course_screen.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPageTitle(
              title: "Forgot Password",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            Text(
              "We will send the OTP code to your email for security in forgetting your password",
              style: ParagraphBody.mediumRegular,
            ),
            const SizedBox(height: 32),
            CustomFormInput(
              height: 56,
              width: double.infinity,
              hintText: 'Ex : Johndoe@gmail.com',
              controller: emailController,
            ),
            const SizedBox(height: 460),
            MainButton(
                text: "Send",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailCourse(),
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
    );
  }
}
