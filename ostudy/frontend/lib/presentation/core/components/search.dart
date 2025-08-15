import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_colors.dart';

class Search extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: NeutralColors.black100),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search Class, Category, etc",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: SvgPicture.asset(
              'assets/icon/search-03.svg',
              height: 20,
              width: 20,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 30, bottom: 20),
        ),
      ),
    );
  }
}
