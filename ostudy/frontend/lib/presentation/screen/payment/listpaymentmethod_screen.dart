import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';

class ListPaymentMethod extends StatefulWidget {
  const ListPaymentMethod({super.key});

  @override
  State<ListPaymentMethod> createState() => _ListPaymentMethodState();
}

class _ListPaymentMethodState extends State<ListPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: CustomPageTitle(
        title: "Payment",
        onPressed: () {
          Navigator.pop(context);
        },
        showRightIcon: true,
        rightIconAsset: "assets/icons/plus.svg",
        onRightIconPressed: () {
          print("Right icon clicked");
        },
      )),
    );
  }
}
