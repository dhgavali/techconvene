// Add routes used in application

import 'package:get/get.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/screens/auth/authpage.dart';
import 'package:techconvene/screens/auth/hostSignup.dart';
import 'package:techconvene/screens/auth/hostlogin.dart';
import 'package:techconvene/screens/auth/loginpage.dart';
import 'package:techconvene/screens/auth/onboarding.dart';
import 'package:techconvene/screens/auth/signup_page.dart';
import 'package:techconvene/screens/host/adminLanding.dart';
import 'package:techconvene/screens/host/adminhome.dart';
import 'package:techconvene/screens/host/post_event/event_form.dart';
import 'package:techconvene/screens/host/post_event/select_poster.dart';
import 'package:techconvene/screens/users/landing.dart';
import 'package:techconvene/screens/users/homepage.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesNames.onboard,
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      name: RoutesNames.authPage,
      page: () => AuthPage(),
    ),
    GetPage(
      name: RoutesNames.hostlogin,
      page: () => HostLogin(),
    ),
    GetPage(
      name: RoutesNames.hostsignup,
      page: () => HostSignupScreen(),
    ),

    // user pages
    GetPage(
      name: RoutesNames.landingPage,
      page: () => LandingPage(),
    ),
    GetPage(
      name: RoutesNames.homeScreen,
      page: () => HomePage(),
    ),
    GetPage(
      name: RoutesNames.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RoutesNames.signupScreen,
      page: () => SignupScreen(),
    ),

    // adminpages
    // adminpages
    GetPage(
      name: RoutesNames.adminLanding,
      page: () => AdminLanding(),
    ),
    GetPage(
      name: RoutesNames.adminHome,
      page: () => const AdminHome(),
    ),
    GetPage(
      name: RoutesNames.eventforms,
      page: () => EventForm(),
    ),
    GetPage(
      name: RoutesNames.selectposter,
      arguments: AppRoutes,
      page: () => const SelectPoster(),
    ),
  ];
}
