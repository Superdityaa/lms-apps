import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/bottomsheet_onboarding.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_transition.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';
import 'package:ostudy/presentation/screen/boarding/boarding_fifth.dart';

class BoardingFourthScreen extends StatelessWidget {
  const BoardingFourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _navigateToPage(Widget page) {
      Navigator.push(
        context,
        TransitionPage(page: page),
      );
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: GradientColors.lightGradient,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 72, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/logo-text.png',
                      width: 75, height: 50),
                  TextButton(
                    onPressed: () {
                      _navigateToPage(const LoginScreen());
                    },
                    child: Text(
                      "Skip",
                      style: ParagraphBody.mediumRegular,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  'assets/images/onboarding.png',
                ),
              ),
            ),
            BottomSheetOnBoarding(
              headerText: "Begin Your Learning \nAdventure",
              subHeaderText:
                  "Tailor-Made Courses, Expert Instructors, and a World of Knowledge Awaits You at OStudy",
              onButtonPressed: () {
                _navigateToPage(const BoardingFifthScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
