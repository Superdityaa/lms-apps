import 'package:flutter/material.dart';
import 'package:ostudy/presentation/screen/boarding/boarding_second.dart';

class BoardingFirstScreen extends StatefulWidget {
  const BoardingFirstScreen({super.key});

  @override
  State<BoardingFirstScreen> createState() => _BoardingFirstScreenState();
}

class _BoardingFirstScreenState extends State<BoardingFirstScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BoardingSecondScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo-text.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
