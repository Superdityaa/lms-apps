import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class AvatarProfile extends StatelessWidget {
  final bool isEditable;
  final VoidCallback? onEdit;

  const AvatarProfile({
    super.key,
    this.isEditable = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/defaultpict.jpg'),
        ),
        if (isEditable)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color:AppColors.orange500,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: NeutralColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
