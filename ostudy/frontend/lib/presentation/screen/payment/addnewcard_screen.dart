import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPageTitle(
          title: "Add New Card",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
