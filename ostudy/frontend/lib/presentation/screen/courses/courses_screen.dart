import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/search.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 81),
            Center(
              child: Text("My Course", style: HeadingBold.heading5),
            ),
            const SizedBox(height: 32),
            Search(),
          ],
        ),
      ),
    );
  }
}
