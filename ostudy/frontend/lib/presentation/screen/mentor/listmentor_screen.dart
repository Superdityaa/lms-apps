import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

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
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarProfile(
                  isEditable: true,
                ),
                Column(
                  children: [],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
