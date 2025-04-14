import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class CustomAccordion extends StatelessWidget {
  final String title;
  final String description;

  const CustomAccordion({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NeutralColors.white,
      decoration: BoxDecoration(
        border: Border.all(color: NeutralColors.black50),
      ),
      child: ExpansionTile(
        leading: SvgPicture.asset(
          'assets/icons/chevron-down.svg',
          // ignore: deprecated_member_use
          color: AppColors.orange500,
          height: 18,
          width: 18,
        ),
        title: Text(
          title,
          style: ParagraphBody.mediumBold,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: ParagraphBody.smallRegular,
            ),
          ),
        ],
      ),
    );
  }
}
