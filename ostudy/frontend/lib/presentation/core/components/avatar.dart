import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class AvatarProfile extends StatelessWidget {
  final bool isEditable;
  final String? avatarUrl;
  final VoidCallback? onEdit;
  final double radius;
  final double? editIconSize;
  final double? editButtonPadding;

  const AvatarProfile({
    super.key,
    this.avatarUrl,
    this.isEditable = false,
    this.onEdit,
    this.radius = 50,
    this.editIconSize,
    this.editButtonPadding,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = editIconSize ?? (radius * 0.36);
    final buttonPadding = editButtonPadding ?? (radius * 0.12);
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: radius,
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
                padding: EdgeInsets.all(buttonPadding),
                decoration: const BoxDecoration(
                  color: AppColors.orange500,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  size: iconSize,
                  color: NeutralColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
