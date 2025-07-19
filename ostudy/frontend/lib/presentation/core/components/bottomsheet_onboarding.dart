import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class BottomSheetOnBoarding extends StatelessWidget {
  final String headerText;
  final String subHeaderText;
  final VoidCallback onButtonPressed;

  const BottomSheetOnBoarding({
    super.key,
    required this.headerText,
    required this.subHeaderText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NeutralColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headerText,
                  style: HeadingBold.heading5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(subHeaderText, style: ParagraphBody.smallRegular),
          ),
          const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: MainButton(
              text: "Next",
              width: 400,
              height: 50,
              onPressed: onButtonPressed,
              color: AppColors.orange500,
              textColor: NeutralColors.white,
            ),
          )
        ],
      ),
    );
  }
}
