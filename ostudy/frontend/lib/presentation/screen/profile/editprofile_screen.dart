import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            CustomPageTitle(
              title: "Profile",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            const AvatarProfile(
              isEditable: true,
            ),
            const SizedBox(height: 32),
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
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }
}
