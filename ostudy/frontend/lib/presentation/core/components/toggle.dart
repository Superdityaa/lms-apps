import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;

  const ToggleSwitch({
    super.key,
    this.value = false,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 50,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: value ? AppColors.orange500 : NeutralColors.black200,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(3),
            width: 19,
            height: 19,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
