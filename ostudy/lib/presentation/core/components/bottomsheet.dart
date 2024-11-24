import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomSheet({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.orange500,
      unselectedItemColor: NeutralColors.black200,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/icons/home-02.svg',
              // ignore: deprecated_member_use
              color: NeutralColors.black200,
              height: 18,
            ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/icons/home-02.svg',
              // ignore: deprecated_member_use
              color: NeutralColors.black200,
              height: 18,
            ),
          label: "Course",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/icons/heart-3-line.svg',
              // ignore: deprecated_member_use
              color: NeutralColors.black200,
              height: 18,
            ),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/icons/user-3-line.svg',
              // ignore: deprecated_member_use
              color: NeutralColors.black200,
              height: 18,
            ),
          label: "Profile",
        ),
      ],
    );
  }
}
