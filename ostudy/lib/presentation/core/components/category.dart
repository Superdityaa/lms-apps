import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: AppColors.orange50,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
