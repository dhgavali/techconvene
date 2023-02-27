import 'package:flutter/material.dart';

class AppColors {
  static LinearGradient bgGradient = const LinearGradient(
    colors: [
      Color(0xff0E3364),
      Colors.black,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient cyanGradient = const LinearGradient(
    colors: [
      Color(0xff79DFC8),
      Color(0xff7A9CE0),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color greyColor = Color(0xffB3B3B3);
  static const Color black = Color(0xff010101);

  static const Color greyAccentColor = Color(0xff2F3859);

  static Color whiteColor = const Color(0xffFFFFFF).withOpacity(0.9);
  static const Color kblue = Color(0xff2196f3);

  static Color darkGreyColor = const Color(0xff000000).withOpacity(0.27);
  static Color shadowColor =
      const Color.fromARGB(255, 168, 168, 168).withOpacity(0.27);

  static Color darkBlueColor = const Color(0xff0E3364);
  static const Color lightBlue = Color(0xff8DEBFF);
  static Color bgWhite = const Color(0xffffffff).withOpacity(0.05);
  static Color btmNavColor = const Color.fromRGBO(36, 54, 101, 1.0);
}
