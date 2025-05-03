import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/form_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CustomFormInput(hintText: 'Ex : Johndoe@gmail.com', width: 350, height: 100,)),
    );
  }
}
