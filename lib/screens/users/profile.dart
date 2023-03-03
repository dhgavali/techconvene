import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/router/route_names.dart';

import '../../services/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await AuthMethods().signOut();
              // setState(() {
              //   isloading = !isloading;
              // });
              Get.offAllNamed(RoutesNames.loginScreen);
            },
            child: Text("Logout")),
      ),
    );
  }
}
