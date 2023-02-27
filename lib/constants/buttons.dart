import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';

class PrimaryBtn extends StatelessWidget {
  final String label;
  final Function() onpress;
  final double hr, vr, width, height;
  final Color bgColor;
  const PrimaryBtn({
    super.key,
    required this.label,
    required this.onpress,
    this.width = 285,
    this.height = 45,
    this.hr = 0,
    this.vr = 5,
    this.bgColor = AppColors.kblue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: hr, vertical: vr),
          width: width.w,
          height: height.h,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                color: AppColors.shadowColor,
                blurRadius: 4.r,
              ),
              BoxShadow(
                offset: Offset(2, 2),
                color: AppColors.shadowColor,
                blurRadius: 4.r,
              ),
            ],
          ),
          child: Text(
            label,
            style: MyTextStyles.customStyle(
              fontsize: 14,
              fontWeight: FontWeight.w700,
              fontcolor: AppColors.whiteColor,
            ),
          )),
    );
  }
}
