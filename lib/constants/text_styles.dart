import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';

class MyTextStyles {
  static const String poppinsFont = "Poppins";

  static TextStyle get poppins700 => TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        color: AppColors.darkBlueColor,
      );

  static TextStyle get poppins600 => TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w600,
        fontSize: 10.sp,
        color: AppColors.darkGreyColor,
      );

  static TextStyle get poppins500 => TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w500,
        fontSize: 10.sp,
        color: AppColors.whiteColor,
      );

  static TextStyle get poppins400 => TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        color: AppColors.greyColor,
      );

  static TextStyle customStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontsize = 10,
    Color fontcolor = AppColors.greyColor,
  }) {
    return TextStyle(
      fontFamily: poppinsFont,
      fontWeight: fontWeight,
      fontSize: fontsize.sp,
      color: fontcolor,
    );
  }
}

class MyTexts {
  static const String poppinsFont = "Poppins";
  static Widget h1(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        color: AppColors.darkBlueColor,
      ),
    );
  }

  static Widget h2(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        color: AppColors.darkBlueColor,
      ),
    );
  }

  static Widget h4(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: AppColors.darkBlueColor,
      ),
    );
  }

  static Widget h5(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: AppColors.black,
      ),
    );
  }
}
