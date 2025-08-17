import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPageTitle(
          title: "Profile",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
