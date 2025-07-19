import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_transition.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';
import 'package:ostudy/presentation/screen/boarding/boarding_third.dart';

class StarterPageScreen extends StatelessWidget {
  const StarterPageScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            Text(
              "Find out what you're \ninterested in",
              style: HeadingBold.heading5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "To provide you with class recommendations.",
              style: ParagraphBody.smallRegular,
              textAlign: TextAlign.center,
            ),
            








            const SizedBox(height: 24),
            Text(
              "Your Current Selections Are Not Fixed. Explore Countless Learning Opportunities and Tailor Your Path as You Progress.",
              style: ParagraphBody.smallRegular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            MainButton(
                text: "Next",
                width: 350,
                height: 50,
                textColor: NeutralColors.black500,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BoardingThirdScreen(),
                    ),
                  );
                },
                color: NeutralColors.white)
          ],
        ),
      ),
    );
  }
}
