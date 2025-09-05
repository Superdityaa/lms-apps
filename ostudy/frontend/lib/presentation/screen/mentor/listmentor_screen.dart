import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class ListMentor extends StatefulWidget {
  const ListMentor({super.key});

  @override
  State<ListMentor> createState() => _ListMentorState();
}

class _ListMentorState extends State<ListMentor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: CustomPageTitle(
        title: "Our Mentor",
        onPressed: () {
          Navigator.pop(context);
        },
      )),
    );
  }
}
