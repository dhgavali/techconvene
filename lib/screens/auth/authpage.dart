import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/screens/auth/loginpage.dart';
import 'package:techconvene/screens/auth/onboarding.dart';
import 'package:techconvene/screens/host/adminhome.dart';
import 'package:techconvene/screens/users/homepage.dart';
import 'package:techconvene/shared/SharedData.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? role;

  Future<String> getLogStatus() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return RoutesNames.onboard;
    } else {
      role = await SharedData.getRole();
      if (role == "user") {
        return RoutesNames.landingPage;
      } else if (role == "admin") {
        return RoutesNames.adminLanding;
      } else {
        return RoutesNames.onboard;
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getLogStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                String route = snapshot.data!;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Get.toNamed(route);
                });
                print(route);
              }
            }
            return Center(
              child: Loadings.basic(),
            );
          }),
    );
    // return FutureBuilder(
    // future: getLogStatus(), builder: (context, snapshot) => );
    // }
  }
}
