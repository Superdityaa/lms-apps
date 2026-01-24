import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/courses/courses_screen.dart';
import 'package:ostudy/presentation/screen/favorite/favorite_screen.dart';
import 'package:ostudy/presentation/screen/home/home_screen.dart';
import 'package:ostudy/presentation/screen/profile/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NeutralColors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: 'assets/icon/home-02.svg',
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                icon: 'assets/icon/book-mark-line.svg',
                label: 'Course',
              ),
              _buildNavItem(
                index: 2,
                icon: 'assets/icon/heart-3-line.svg',
                label: 'Favorite',
              ),
              _buildNavItem(
                index: 3,
                icon: 'assets/icon/user-3-line.svg',
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.orange500 : NeutralColors.black100,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: ParagraphBody.xsmallBold),
          ],
        ),
      ),
    );
  }
}

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    return Obx(() => Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
          ),
        ));
  }
}

// GetX Controller for navigation
class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  final List<Widget> pages = [
    const Home(),
    const ListCourse(),
    const FavoriteCourse(),
    const Profile(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
