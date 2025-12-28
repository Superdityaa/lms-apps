import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/button.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/components/toggle.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';
import 'package:ostudy/presentation/screen/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotification extends StatefulWidget {
  const SettingsNotification({super.key});

  @override
  State<SettingsNotification> createState() => _SettingsNotificationState();
}

class _SettingsNotificationState extends State<SettingsNotification> {
  bool upcomingClass = false;
  bool reminderPromo = false;
  bool reminderClass = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      upcomingClass = prefs.getBool('upcomingClass') ?? false;
      reminderPromo = prefs.getBool('reminderPromo') ?? false;
      reminderClass = prefs.getBool('reminderClass') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('upcomingClass', upcomingClass);
    await prefs.setBool('reminderPromo', reminderPromo);
    await prefs.setBool('reminderClass', reminderClass);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: NeutralColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPageTitle(
                title: "Notifications",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.06),
              Row(
                children: [
                  Text(
                    "Upcoming Class",
                    style: ParagraphBody.mediumBold,
                  ),
                  const Spacer(),
                  ToggleSwitch(
                    value: upcomingClass,
                    onToggle: (value) {
                      setState(() => upcomingClass = value);
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              const Divider(),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Text(
                    "Reminder Promo",
                    style: ParagraphBody.mediumBold,
                  ),
                  const Spacer(),
                  ToggleSwitch(
                    value: reminderPromo,
                    onToggle: (value) {
                      setState(() => reminderPromo = value);
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              const Divider(),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Text(
                    "Reminder Class",
                    style: ParagraphBody.mediumBold,
                  ),
                  const Spacer(),
                  ToggleSwitch(
                    value: reminderClass,
                    onToggle: (value) {
                      setState(() => reminderClass = value);
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              const Divider(),
              SizedBox(height: size.height * 0.43),
              MainButton(
                  text: "Save Changes",
                  onPressed: () async {
                    await _saveSettings();
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
      ),
    );
  }
}
