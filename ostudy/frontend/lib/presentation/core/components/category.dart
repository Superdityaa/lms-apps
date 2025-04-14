import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {"title": "Coding", "icon": "assets/icons/code.svg"},
      {"title": "Editing", "icon": "assets/icons/laptop.svg"},
      {"title": "Illustration", "icon": "assets/icons/pen-tool.svg"},
      {"title": "UI/UX", "icon": "assets/icons/lamp.svg"},
      {"title": "More", "icon": "assets/icons/puzzle.svg"},
    ];

    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 32,
          runSpacing: 32,
          alignment: WrapAlignment.center,
          children: categories.map((category) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.orange50,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(category["icon"]!),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  category["title"]!,
                  style: ParagraphBody.xsmallBold,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
