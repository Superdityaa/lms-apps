import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class CustomPageTitle extends StatelessWidget {
  final String title;
  final bool showLeftIcon;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool showRightIcon;
  final String? rightIconAsset;
  final VoidCallback? onRightIconPressed;

  const CustomPageTitle({
    required this.title,
    this.onPressed,
    this.icon,
    this.showLeftIcon = true,
    this.showRightIcon = false,
    this.rightIconAsset,
    this.onRightIconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left icon
            if (showLeftIcon)
              GestureDetector(
                onTap: onPressed,
                child: icon ??
                    SvgPicture.asset(
                      'assets/icon/arrow-narrow-left.svg',
                      height: 18,
                      color: NeutralColors.black500,
                    ),
              )
            else
              const SizedBox(width: 20), // Placeholder supaya balance

            // Title (selalu center)
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: HeadingBold.heading5,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Right icon
            if (showRightIcon && rightIconAsset != null)
              GestureDetector(
                onTap: onRightIconPressed,
                child: SvgPicture.asset(
                  rightIconAsset!,
                  height: 20,
                ),
              )
            else
              const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
