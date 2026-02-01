import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/card.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/components/search.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                title: "Search",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.04),
              Search(),
              SizedBox(height: size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryBox(
                      "UI/UX",
                      "assets/images/uiux.jpg",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryBox(
                      "Code",
                      "assets/images/programming.jpg",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryBox(
                      "Editing",
                      "assets/images/video-editing.jpg",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryBox(
                      "Illustration",
                      "assets/images/illustration.jpg",
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top Class",
                    style: ParagraphBody.mediumBold,
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

  Widget _buildCategoryBox(String title, String imageAsset) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            NeutralColors.black100,
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: ParagraphBody.mediumBold.copyWith(
            color: NeutralColors.white,
          ),
        ),
      ),
    );
  }
}
