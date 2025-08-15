import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/bottomnavbar.dart';
import 'package:ostudy/presentation/core/components/search.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 81),
            Center(
              child: Text("My Course", style: HeadingBold.heading5),
            ),
            const SizedBox(height: 32),
            Search()
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
