import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import '../utils/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final Color? color;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: color ?? AppColors.orange500,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: ParagraphBody.mediumBold,
            ),
          ],
        ),
      ),
    );
  }
}
