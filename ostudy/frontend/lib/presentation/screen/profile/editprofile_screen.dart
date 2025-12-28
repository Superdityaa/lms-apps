import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/profile/profile_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
                title: "Profile",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.04),
              const AvatarProfile(
                isEditable: true,
              ),
              SizedBox(height: size.height * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Complete Name", style: ParagraphBody.mediumBold),
                  const SizedBox(height: 8),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "Complete Name",
                    isPassword: false,
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username", style: ParagraphBody.mediumBold),
                  const SizedBox(height: 8),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "Username",
                    isPassword: false,
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email", style: ParagraphBody.mediumBold),
                  const SizedBox(height: 8),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "Email",
                    isPassword: false,
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address", style: ParagraphBody.mediumBold),
                  const SizedBox(height: 8),
                  const CustomFormInput(
                    height: 56,
                    width: double.infinity,
                    hintText: "Address",
                    isPassword: false,
                  )
                ],
              ),
              SizedBox(height: size.height * 0.04),
              MainButton(
                  text: "Save Changes",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    );
                  },
                  width: double.infinity,
                  height: 56,
                  color: AppColors.orange500,
                  textColor: NeutralColors.white)
            ],
          ),
        ),
      ),
    );
  }
}
