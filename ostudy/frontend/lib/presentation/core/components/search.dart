import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: NeutralColors.white,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search class, category, etc",
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SvgPicture.asset(
              'assets/icons/search-03.svg',
              height: 18,
            ),
          ),
        ),
      ),
    );
  }
}
