import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPageTitle(
          title: "Change Password",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
