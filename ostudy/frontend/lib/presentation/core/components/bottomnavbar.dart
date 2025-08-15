import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/screen/courses/courses_screen.dart';
import 'package:ostudy/presentation/screen/home/home_screen.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({super.key});

  final NavController navC = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: navC.selectedIndex.value,
          onTap: (index) => navC.changeTab(index, context),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.orange500,
          unselectedItemColor: NeutralColors.black200,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book),
              label: "Courses",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ));
  }
}

class NavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index, BuildContext context) {
    if (selectedIndex.value == index) return; // kalau tab sama, tidak pindah

    selectedIndex.value = index;

    Widget page;
    switch (index) {
      case 0:
        page = const Home();
        break;
      case 1:
        page = const Courses();
        break;
      default:
        page = const Home();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
