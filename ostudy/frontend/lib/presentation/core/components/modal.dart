import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final String textButton;
  final String image;
  final Callback onPressed;

  const CustomModal(
      {Key? key,
      required this.title,
      required this.image,
      required this.textButton,
      required this.onPressed})
      : super(key: key);

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
            Image.asset(image, width: 100),
            const SizedBox(height: 32),
            Text(title, style: HeadingBold.heading6),
            const SizedBox(height: 8),
            Row(
              children: [
                MainButton(
                    text: textButton,
                    onPressed: onPressed,
                    width: 200,
                    height: 50,
                    color: AppColors.orange500,
                    textColor: NeutralColors.white)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
