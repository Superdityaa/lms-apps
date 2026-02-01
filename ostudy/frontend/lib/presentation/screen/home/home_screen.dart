import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/featuredclasshome.dart';
import 'package:ostudy/presentation/core/components/search.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/home/all_class.dart';
import 'package:ostudy/presentation/screen/home/search.dart';
import 'package:ostudy/presentation/screen/mentor/listmentor_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> _categories = [
    {
      'title': 'Code',
      'icon': 'assets/icon/code.svg',
    },
    {
      'title': 'Editing',
      'icon': 'assets/icon/laptop.svg',
    },
    {
      'title': 'Illustration',
      'icon': 'assets/icon/pen-tool.svg',
    },
    {
      'title': 'UI/UX',
      'icon': 'assets/icon/lamp.svg',
    },
    {
      'title': 'More',
      'icon': 'assets/icon/puzzle.svg',
    },
  ];

  Widget _buildCategoryItem({
    required String title,
    required String icon,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.orange50,
            ),
            child: SvgPicture.asset(
              icon,
              width: 32,
              height: 32,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: ParagraphBody.xsmallBold,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: NeutralColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              decoration: const BoxDecoration(
                color: AppColors.orange500,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AvatarProfile(
                        isEditable: false,
                        radius: 30,
                      ),
                      SizedBox(width: size.width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Good Morning",
                            style: HomeTextStyles.greetingText,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Aditiya Mahendra",
                            style: HomeTextStyles.profileName,
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: NeutralColors.white,
                          ),
                          child: SvgPicture.asset(
                            'assets/icon/notifications.svg',
                            width: 18.0,
                            height: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Search(
                    onTap: () {
                      Get.to(() => const SearchScreen());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: ParagraphBody.mediumBold,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Wrap(
                    spacing: 16,
                    children: _categories.map((category) {
                      return _buildCategoryItem(
                        title: category['title']!,
                        icon: category['icon']!,
                        onTap: () {
                          debugPrint('Clicked category: ${category['title']}');
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Featured Class",
                        style: ParagraphBody.mediumBold,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const AllClass());
                        },
                        child: Text(
                          "See all",
                          style: HomeTextStyles.seeAllText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return FeaturedClassCard(
                    duration: '1H 23 Min',
                    image: 'assets/images/bg-onboarding.png',
                    category: 'UI/UX',
                    title: 'UX for Beginner',
                    rating: '4.6/5',
                    authorName: 'Alex',
                    authorRole: 'UI Designer',
                    authorAvatar: 'assets/images/defaultpict.jpg',
                    price: '\$112',
                    onTap: () {},
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemCount: 5,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Top Mentor",
                        style: ParagraphBody.mediumBold,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ListMentor());
                        },
                        child: Text(
                          "See all",
                          style: HomeTextStyles.seeAllText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AvatarProfile(
                        isEditable: true,
                        avatarUrl: 'assets/images/defaultpict.jpg',
                        radius: 25,
                      ),
                      Text("Testing", style: ParagraphBody.smallBold),
                      SizedBox(height: size.height * 0.01),
                      Text("UI/UX Designer",
                          style: ParagraphBody.xsmallRegular),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
