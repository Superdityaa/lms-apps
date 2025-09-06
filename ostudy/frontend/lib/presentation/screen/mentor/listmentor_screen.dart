import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class ListMentor extends StatefulWidget {
  const ListMentor({super.key});

  @override
  State<ListMentor> createState() => _ListMentorState();
}

class _ListMentorState extends State<ListMentor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            CustomPageTitle(
              title: "Our Mentor",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AvatarProfile(
                  isEditable: true,
                ),
                Column(
                  children: [
                    Text("Jonny", style: ParagraphBody.smallBold),
                    Text(
                      "Web Developer",
                      style: ParagraphBody.xsmallRegular,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
