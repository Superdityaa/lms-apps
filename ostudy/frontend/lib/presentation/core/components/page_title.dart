import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class CustomPageTitle extends StatelessWidget {
  final String title;
  final Widget? icon;
  final VoidCallback onPressed;
  final bool showRightIcon;
  final String? rightIconAsset;
  final VoidCallback? onRightIconPressed;

  const CustomPageTitle({
    required this.title,
    required this.onPressed,
    this.icon,
    this.showRightIcon = false,
    this.rightIconAsset,
    this.onRightIconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 81),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onPressed,
                child: SvgPicture.asset(
                  'assets/icons/arrow-narrow-left.svg',
                  height: 18,
                  color: NeutralColors.black500,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: HeadingBold.heading5,
                  ),
                ),
              ),
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
        ),
      ],
    );
  }
}
