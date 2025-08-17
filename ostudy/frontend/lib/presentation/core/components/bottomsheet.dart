import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class CustomBottomsheet extends StatelessWidget {
  final String textButton;
  final Widget? icon;
  final VoidCallback onPressed;

  const CustomBottomsheet({
    required this.textButton,
    required this.onPressed,
    this.icon,
    super.key,
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
                CustomOutlinedButton(
                  text: textButton,
                  onPressed: onPressed,
                  icon: icon,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
