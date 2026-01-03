import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/search.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              height: size.height * 0.30,
              padding: const EdgeInsets.fromLTRB(16, 64, 16, 24),
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
                      const CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage('assets/images/defaultpict.jpg'),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, Good Morning",
                              style: HomeTextStyles.greetingText),
                          const SizedBox(height: 4),
                          Text("Aditiya Mahendra",
                              style: HomeTextStyles.profileName),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  const Search(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
