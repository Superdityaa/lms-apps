import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/card.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/components/search.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class AllClass extends StatefulWidget {
  const AllClass({super.key});

  @override
  State<AllClass> createState() => _AllClassState();
}

class _AllClassState extends State<AllClass> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: NeutralColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              CustomPageTitle(
                title: "All Class",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.04),
              Search(),
              SizedBox(height: size.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CardCourse(
                    imageUrl: "assets/images/defaultpict.jpg",
                    category: "UI/UX Design",
                    title: "UI/UX for Beginners: Learn the Fundamentals",
                    duration: "5H 45Min",
                    rating: 4.8,
                    badgeText: "\$150",
                  ),
                  SizedBox(height: size.height * 0.02),
                  const CardCourse(
                    imageUrl: "assets/images/defaultpict.jpg",
                    category: "UI/UX Design",
                    title: "UI/UX for Beginners: Learn the Fundamentals",
                    duration: "5H 45Min",
                    rating: 4.8,
                    badgeText: "\$150",
                  ),
                  SizedBox(height: size.height * 0.02),
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
            ],
          ),
        ),
      ),
    );
  }
}
