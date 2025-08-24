import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/profile/profile_screen.dart';

class ListLanguage extends StatefulWidget {
  const ListLanguage({super.key});

  @override
  State<ListLanguage> createState() => _ListLanguageState();
}

class _ListLanguageState extends State<ListLanguage> {
  final List<Map<String, dynamic>> _listLanguage = [
    {"title": "English", "isSelected": true},
    {"title": "Bahasa Indonesia", "isSelected": false},
    {"title": "Chinese", "isSelected": false},
    {"title": "Korean", "isSelected": false},
    {"title": "Filipino", "isSelected": false},
    {"title": "English (UK)", "isSelected": false},
  ];

  void _toggleSelection(int index) {
    setState(() {
      _listLanguage[index]["isSelected"] = !_listLanguage[index]["isSelected"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPageTitle(
              title: "Language",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            Text(
              "Choose Language",
              style: ParagraphBody.mediumRegular,
            ),
            const SizedBox(height: 32),
            Column(
              children: List.generate(
                _listLanguage.length,
                (index) {
                  final language = _listLanguage[index];
                  final isSelected = language["isSelected"] as bool;

                  return GestureDetector(
                    onTap: () => _toggleSelection(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.orange50
                            : NeutralColors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.orange500
                              : NeutralColors.black50,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              language["title"],
                              style: ParagraphBody.mediumRegular,
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.orange500
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.orange50
                                    : NeutralColors.black50,
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 10,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 150),
            MainButton(
                text: "Send",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                width: 400,
                height: 50,
                color: AppColors.orange500,
                textColor: NeutralColors.white),
          ],
        ),
      ),
    );
  }
}
