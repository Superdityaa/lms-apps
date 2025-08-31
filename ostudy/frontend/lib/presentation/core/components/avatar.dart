import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class AvatarProfile extends StatelessWidget {
  final bool isEditable;
  final String? avatarUrl;
  final VoidCallback? onEdit;

  const AvatarProfile({
    super.key,
    this.avatarUrl,
    this.isEditable = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty)
              ? NetworkImage(avatarUrl!)
              : const AssetImage('assets/images/defaultpict.jpg')
                  as ImageProvider,
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
                  color: AppColors.orange500,
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
