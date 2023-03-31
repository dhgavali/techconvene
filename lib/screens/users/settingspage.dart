import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          MenuRow(
            label: "Profile",
            icon: Icons.person,
            onpress: () {
              // print("hello");
              Get.toNamed(RoutesNames.profilePage);
            },
          ),
          MenuRow(
            label: "Account",
            icon: Icons.settings,
            onpress: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("This feature will be activated soon")));
            },
          ),
          MenuRow(
            label: "notifications",
            icon: Icons.notifications,
            onpress: () {
              Get.toNamed(RoutesNames.userNotification);
            },
          ),
          MenuRow(
            label: "Privacy",
            icon: Icons.security,
            onpress: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("This feature will be activated soon")));
            },
          ),
          MenuRow(
            label: "Logout",
            icon: Icons.logout,
            onpress: () async {
              await AuthMethods().signOut();
            },
          ),
        ]),
      )),
    );
  }
}

class MenuRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onpress;
  const MenuRow({
    Key? key,
    required this.label,
    required this.icon,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.grey.shade200,
            )
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.btmNavColor,
              ),
              const SizedBox(
                width: 15,
              ),
              MyTexts.h3(label),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.btmNavColor,
          ),
        ]),
      ),
    );
  }
}
