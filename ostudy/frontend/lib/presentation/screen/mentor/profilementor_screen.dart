import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class ProfileMentor extends StatefulWidget {
  const ProfileMentor({super.key});

  @override
  State<ProfileMentor> createState() => _ProfileMentorState();
}

class _ProfileMentorState extends State<ProfileMentor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: const BoxDecoration(
                  color: AppColors.orange500,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    CustomPageTitle(
                      title: "Our Mentor",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 65),
                  ],
                ),
              ),
              const Positioned(
                bottom: -40,
                left: 0,
                right: 0,
                child: Center(
                  child: AvatarProfile(
                    isEditable: false,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text("John Doe", style: ParagraphBody.smallBold),
              Text(
                "UI/UX Designer",
                style: ParagraphBody.xsmallRegular,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
