// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool showLeadingIcon;

  CustomAppBar({
    required this.title,
    this.height = 70,
    this.showLeadingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeutralColors.white,
      leading: showLeadingIcon
          ? Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/arrow-narrow-left.svg',
                  color: NeutralColors.black500,
                  height: 18,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      title: Center(
        child: Text(
          title,
          style: HeadingBold.heading6,
        ),
      ),
      toolbarHeight: height,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
