import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String textButton;
  final String image;

  const CustomAlert({
    Key? key,
    required this.title,
    required this.image,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          color: NeutralColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(image, width: 200),
            const SizedBox(height: 32),
            Text(title, style: HeadingBold.heading6),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MainButton(
                    color: AppColors.orange500,
                    width: 200,
                    height: 50,
                    text: textButton,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    }, textColor: NeutralColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
