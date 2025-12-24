import 'package:flutter/material.dart';

class AppColors {
  static const Color orange50 = Color(0xFFFEEEEA);
  static const Color orange100 = Color(0xFFFBCCBD);
  static const Color orange200 = Color(0xFFF9B39D);
  static const Color orange300 = Color(0xFFF69070);
  static const Color orange400 = Color(0xFFF47A54);
  static const Color orange500 = Color(0xFFF15929);
  static const Color orange600 = Color(0xFFDB5125);
  static const Color orange700 = Color(0xFFAB3F1D);
  static const Color orange800 = Color(0xFF853117);
  static const Color orange900 = Color(0xFF652511);

  static white() {}
}

class NeutralColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black50 = Color(0xFFE7E7E7);
  static const Color black100 = Color(0xFFB4B4B4);
  static const Color black200 = Color(0xFF909090);
  static const Color black300 = Color(0xFF5D5D5D);
  static const Color black400 = Color(0xFF3D3D3D);
  static const Color black500 = Color(0xFF0D0D0D);
  static const Color black600 = Color(0xFF0C0C0C);
  static const Color black700 = Color(0xFF090909);
  static const Color black800 = Color(0xFF070707);
  static const Color black900 = Color(0xFF050505);
}

class GradientColors {
  static const LinearGradient darkGradient = LinearGradient(
    colors: [AppColors.orange500, NeutralColors.white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient lightGradient = LinearGradient(
    colors: [AppColors.orange100, NeutralColors.white],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient lightGradientRevert = LinearGradient(
    colors: [AppColors.orange100, NeutralColors.white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class ValidationFormColors {
  static const Color shadowActive = Color(0xF9B39D69);
  static const Color shadowWrong = Color(0x00ec778d);
  static const Color wrongColor = Color(0xDF1C4126);
}
