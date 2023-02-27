import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';

class AuthLabelWidget extends StatelessWidget {
  final String label1;
  final String label2;
  final Function()? onpress;

  const AuthLabelWidget(
      {super.key, required this.label1, required this.label2, this.onpress});
  // const AuthLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: onpress,
      child: Container(
        alignment: Alignment.center,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 20.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.bgWhite,
        ),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: label1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text: label2,
                style: TextStyle(
                  color: AppColors.darkBlueColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
