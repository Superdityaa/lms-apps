import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPageTitle(
          title: "Forgot Password",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
