import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/shared/SharedData.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: MyTexts.h1("Evently"),
            ),
            Column(
              children: [
                Container(
                  width: width * 0.9,
                  height: width * 0.5,
                  child: Lottie.network(
                      "https://assets7.lottiefiles.com/packages/lf20_3mcu1lCXFW.json"),
                ),
                Center(
                  child: MyTexts.h2(
                      "Unleash your potentials, \nParticipate and win exciting prizes!!"),
                ),
              ],
            ),
            Column(
              children: [
                PrimaryBtn(
                  label: "Participate in Events ",
                  bgColor: AppColors.kblue,
                  onpress: () {
                    Get.toNamed(RoutesNames.loginScreen);
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryBtn(
                  label: "Host Your Event ",
                  bgColor: AppColors.black,
                  onpress: () async {
                   
                    Get.toNamed(RoutesNames.hostlogin);
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
