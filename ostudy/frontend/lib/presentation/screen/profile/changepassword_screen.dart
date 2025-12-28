import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

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
                title: "Change Password",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                "The new password must be different from the current password",
                style: ParagraphBody.mediumRegular,
                textAlign: TextAlign.left,
              ),

              SizedBox(height: size.height * 0.04),

              // Old Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Old Password", style: ParagraphBody.mediumBold),
                  SizedBox(height: size.height * 0.02),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "Old Password",
                    isPassword: true,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              // New Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New Password", style: ParagraphBody.mediumBold),
                  SizedBox(height: size.height * 0.02),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "New Password",
                    isPassword: true,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              // Confirm Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Confirm New Password", style: ParagraphBody.mediumBold),
                  SizedBox(height: size.height * 0.02),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "Confirm New Password",
                    isPassword: true,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.22),
              MainButton(
                text: "Save Changes",
                onPressed: () {},
                width: double.infinity,
                height: 56,
                color: AppColors.orange500,
                textColor: NeutralColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
