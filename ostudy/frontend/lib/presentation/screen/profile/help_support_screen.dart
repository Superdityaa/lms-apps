import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  bool _isExpandedTeamSupport = false;
  bool _isExpandedSupportCenter = false;
  bool _isExpandedExploreFAQ = false;
  bool _isExpandedForgotPassword = false;
  bool _isExpandedRemoveAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPageTitle(
              title: "Help & Support",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  title: Text("Team Support", style: ParagraphBody.mediumBold),
                  trailing: AnimatedRotation(
                    turns: _isExpandedTeamSupport ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more,
                        color: AppColors.orange500),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() => _isExpandedTeamSupport = expanded);
                  },
                  children: [
                    ListTile(
                      title: Text(
                        "Our dedicated support team is ready to assist you with any questions or concerns. Your success is our priority!",
                        style: ParagraphBody.smallRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  title: Text("Support Center at Your Fingertips",
                      style: ParagraphBody.mediumBold),
                  trailing: AnimatedRotation(
                    turns: _isExpandedSupportCenter ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more,
                        color: AppColors.orange500),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() => _isExpandedSupportCenter = expanded);
                  },
                  children: [
                    ListTile(
                      title: Text(
                        "We respect your privacy and are committed to protecting your personal information in accordance with our policies.",
                        style: ParagraphBody.smallRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  title: Text("Explore FAQ's", style: ParagraphBody.mediumBold),
                  trailing: AnimatedRotation(
                    turns: _isExpandedExploreFAQ ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more,
                        color: AppColors.orange500),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() => _isExpandedExploreFAQ = expanded);
                  },
                  children: [
                    ListTile(
                      title: Text(
                        "If you need further assistance, feel free to contact us anytime via email or phone. We’re here to help!",
                        style: ParagraphBody.smallRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  title: Text("Forgotten Password",
                      style: ParagraphBody.mediumBold),
                  trailing: AnimatedRotation(
                    turns: _isExpandedForgotPassword ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more,
                        color: AppColors.orange500),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() => _isExpandedForgotPassword = expanded);
                  },
                  children: [
                    ListTile(
                      title: Text(
                        "If you need further assistance, feel free to contact us anytime via email or phone. We’re here to help!",
                        style: ParagraphBody.smallRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  title:
                      Text("Remove Account", style: ParagraphBody.mediumBold),
                  trailing: AnimatedRotation(
                    turns: _isExpandedRemoveAccount ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more,
                        color: AppColors.orange500),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() => _isExpandedRemoveAccount = expanded);
                  },
                  children: [
                    ListTile(
                      title: Text(
                        "If you need further assistance, feel free to contact us anytime via email or phone. We’re here to help!",
                        style: ParagraphBody.smallRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
