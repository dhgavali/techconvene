import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/controller/adminLand_controller.dart';
import 'package:techconvene/screens/host/adminhome.dart';
import 'package:techconvene/screens/host/hostProfile.dart';
import 'package:techconvene/screens/host/post_event/event_form.dart';
import 'package:techconvene/screens/host/post_event/step_one.dart';
import 'package:techconvene/screens/users/explorepage.dart';

class AdminLanding extends StatelessWidget {
  AdminLanding({super.key});
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: landingPageController.changeTabIndex,
          currentIndex: landingPageController.tabIndex.value,
          backgroundColor: AppColors.btmNavColor,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: const Icon(
                  Icons.home,
                  size: 20.0,
                ),
              ),
              label: 'Home',
              backgroundColor: AppColors.btmNavColor,
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: const Icon(
                  Icons.add_a_photo,
                  size: 20.0,
                ),
              ),
              label: 'Post Event',
              // backgroundColor: AppColors.btmNavColor,
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: const Icon(
                  Icons.person,
                  size: 20.0,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final AdminLandingController landingPageController =
        Get.put(AdminLandingController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              const AdminHome(),
              EventForm(),
              const HostProfile(),
            ],
          )),
    ));
  }
}
