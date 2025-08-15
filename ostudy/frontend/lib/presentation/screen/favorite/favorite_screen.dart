import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/card.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class FavoriteCourse extends StatefulWidget {
  const FavoriteCourse({super.key});

  @override
  State<FavoriteCourse> createState() => _FavoriteCourseState();
}

class _FavoriteCourseState extends State<FavoriteCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 81),
            Center(
              child: Text("My Favorite Class", style: HeadingBold.heading5),
            ),
            const SizedBox(height: 32),
            const CardCourse(
              imageUrl: "assets/images/defaultpict.jpg",
              category: "UI/UX Design",
              title: "UI/UX for Beginners: Learn the Fundamentals",
              duration: "5H 45Min",
              rating: 4.8,
              badgeText: "\$150",
            ),
            const SizedBox(height: 32),
            const CardCourse(
              imageUrl: "assets/images/defaultpict.jpg",
              category: "UI/UX Design",
              title: "UI/UX for Beginners: Learn the Fundamentals",
              duration: "5H 45Min",
              rating: 4.8,
              badgeText: "\$150",
            ),
            const SizedBox(height: 32),
            const CardCourse(
              imageUrl: "assets/images/defaultpict.jpg",
              category: "UI/UX Design",
              title: "UI/UX for Beginners: Learn the Fundamentals",
              duration: "5H 45Min",
              rating: 4.8,
              badgeText: "\$150",
            ),
          ],
        ),
      ),
    );
  }
}
