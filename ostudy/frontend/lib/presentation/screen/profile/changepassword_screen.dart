import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/profile/forgotpassword_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPageTitle(
                  title: "Change Password",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  "The new password must be different from the current password",
                  style: ParagraphBody.mediumRegular,
                ),
                const SizedBox(height: 32),
                _buildInput(
                    "Old Password", "Old Password", oldPasswordController),
                const SizedBox(height: 24),
                _buildInput(
                    "New Password", "New Password", newPasswordController),
                const SizedBox(height: 24),
                _buildInput("Confirm New Password", "Confirm New Password",
                    confirmNewPasswordController),
                const SizedBox(height: 220),
                MainButton(
                    text: "Send",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    width: 400,
                    height: 50,
                    color: AppColors.orange500,
                    textColor: NeutralColors.white)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

@override
Widget _buildInput(String label, String hint, TextEditingController ctrl) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: ParagraphBody.mediumBold),
      const SizedBox(height: 8),
      CustomFormInput(
        height: 56,
        width: double.infinity,
        hintText: hint,
        isPassword: true,
        controller: ctrl,
      ),
    ],
  );
}
