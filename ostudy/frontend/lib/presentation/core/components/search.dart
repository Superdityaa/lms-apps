import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: NeutralColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: NeutralColors.white),
      ),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          hintText: "Search Class, Category, etc",
          hintStyle: const TextStyle(fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icon/search-03.svg',
              width: 20,
              height: 20,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
