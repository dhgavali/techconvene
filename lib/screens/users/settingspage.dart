import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(children: [
          ListTile(
            title: MyTexts.h2("Profile"),
            leading: Icon(
              Icons.person,
              color: AppColors.btmNavColor,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.btmNavColor,
            ),
          ),
        ]),
      )),
    );
  }
}
