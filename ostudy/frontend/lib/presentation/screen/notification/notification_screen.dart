import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: CustomPageTitle(
        title: "Notification",
        onPressed: () {
          Navigator.pop(context);
        },
      )),
    );
  }
}
