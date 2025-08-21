import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class DetailCourse extends StatefulWidget {
  const DetailCourse({super.key});

  @override
  State<DetailCourse> createState() => _DetailCourseState();
}

class _DetailCourseState extends State<DetailCourse> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPageTitle(
              title: "Detail Class",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  title: Text(
                    "1. Introduction",
                    style: ParagraphBody.mediumBold,
                  ),
                  trailing: AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.expand_more,
                      color: AppColors.orange500,
                    ),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _isExpanded = expanded;
                    });
                  },
                  children: [
                    ListTile(
                      title: Text("a. Welcome to UX Design",
                          style: ParagraphBody.smallRegular),
                    ),
                    ListTile(
                      title: Text("b. Fundamental UX Design",
                          style: ParagraphBody.smallRegular),
                    ),
                    ListTile(
                      title: Text("c. UX Design Career",
                          style: ParagraphBody.smallRegular),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
