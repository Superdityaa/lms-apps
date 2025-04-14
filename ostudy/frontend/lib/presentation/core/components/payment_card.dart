import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';

class CustomCardPayment extends StatelessWidget {
  final List<Map<String, dynamic>> paymentCard = [
    {
      
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      color: NeutralColors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: NeutralColors.black50
        ),
      ),
    );

  }
}