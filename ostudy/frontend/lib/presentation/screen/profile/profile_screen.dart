import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/outlined_button.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/auth/login/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: const BoxDecoration(
                  color: AppColors.orange500,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    CustomPageTitle(
                      title: "My Profile",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 65),
                  ],
                ),
              ),
            const Positioned(
                bottom: -40,
                left: 0,
                right: 0,
                child: Center(
                  child: AvatarProfile(
                    isEditable: false,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              children: [
                Text("Personal Information", style: ParagraphBody.smallRegular),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outline),
                  title: Text("Profile", style: ParagraphBody.mediumBold),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: NeutralColors.black500
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.wallet),
                  title: Text("Payment Method", style: ParagraphBody.mediumBold),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: NeutralColors.black500
                  ),
                ),
                const SizedBox(height: 8),
                Text("Security", style: ParagraphBody.smallRegular),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.lock),
                  title: Text("Change Password", style: ParagraphBody.mediumBold),
                  trailing: const Icon(Icons.chevron_right, color: NeutralColors.black500),
                  onTap: () {
                    
                  }
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.lock),
                  title: Text("Forgot Password", style: ParagraphBody.mediumBold),
                  trailing: const Icon(Icons.chevron_right, color: NeutralColors.black500),
                  onTap: () {
                    
                  },
                ),
                const SizedBox(height: 8),
                Text("General", style: ParagraphBody.smallRegular),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.public),
                  title: Text("Language", style: ParagraphBody.mediumBold),
                  trailing: const Icon(Icons.chevron_right, color: NeutralColors.black500),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.notifications),
                  title: Text("Notifications", style: ParagraphBody.mediumBold),
                  trailing: const Icon(Icons.chevron_right, color: NeutralColors.black500),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.help),
                  title: Text("Help & Support", style: ParagraphBody.mediumBold),
                  trailing: const Icon(Icons.chevron_right, color: NeutralColors.black500),
                  onTap: () {
                    
                  },
                ),
                const SizedBox(height: 16),
                CustomOutlinedButton(
                  text: "Logout",
                  color: NeutralColors.black50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
