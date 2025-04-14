import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/bottomsheet_onboarding.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/boarding/boarding_fourth.dart';

class BoardingThirdScreen extends StatefulWidget {
  const BoardingThirdScreen({super.key});

  @override
  State<BoardingThirdScreen> createState() => _BoardingThirdScreenState();
}

class _BoardingThirdScreenState extends State<BoardingThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: GradientColors.lightGradient,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 72),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/logo-text.png',
                      width: 75, height: 50),
                  const SizedBox(width: 150),
                  Text("Skip", style: ParagraphBody.mediumRegular)
                ],
              ),
            ),
            Center(
              child: Image.asset('assets/images/onboarding.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomSheetOnBoarding(
                  headerText: "Your Gateway to Knowledge",
                  subHeaderText:
                      "Discover, Engage, and Achieve Your Educational Goals with Our Innovative Online Platform.",
                  onButtonPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BoardingFourthScreen(),
                      ),
                    );
                  },),
            )
          ],
        ),
      ),
    );
  }
}
