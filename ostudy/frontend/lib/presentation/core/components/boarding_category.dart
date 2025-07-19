import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class BoardingCategory extends StatefulWidget {
  const BoardingCategory({super.key});

  @override
  State<BoardingCategory> createState() => _BoardingCategoryState();
}

class _BoardingCategoryState extends State<BoardingCategory> {
  final List<Map<String, dynamic>> _categories = [
    {
      "title": "Illustrate, Design & Creative",
      "icon": "assets/icon/pen-tool.svg",
      "isSelected": false
    },
    {
      "title": "Product Design & UI/UX",
      "icon": "assets/icon/lamp.svg",
      "isSelected": false
    },
    {
      "title": "Web Development & Coding",
      "icon": "assets/icon/code.svg",
      "isSelected": false
    },
    {
      "title": "Motion & Video Editing",
      "icon": "assets/icon/laptop.svg",
      "isSelected": false
    },
  ];

  void _toggleSelection(int index) {
    setState(() {
      _categories[index]["isSelected"] = !_categories[index]["isSelected"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_categories.length, (index) {
        final category = _categories[index];
        final isSelected = category["isSelected"] as bool;

        return GestureDetector(
          onTap: () => _toggleSelection(index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.orange50 : NeutralColors.white,
              border: Border.all(
                color: isSelected ? AppColors.orange500 : AppColors.orange100,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  category["icon"],
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category["title"],
                    style: ParagraphBody.mediumRegular,
                  ),
                ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.orange500 : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected ? AppColors.orange50 : NeutralColors.black50,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 10,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
