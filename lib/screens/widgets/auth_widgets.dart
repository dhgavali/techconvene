import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIcons extends StatelessWidget {
  const AuthIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            // Google Sign In method
            try {
              await AuthMethods().signInWithGoogle();

              Get.toNamed(RoutesNames.landingPage);
            } catch (e) {
              print(e.toString());
            }
          },
          child: SvgPicture.asset(
            'assets/icons/google.svg',
            width: 40,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        GestureDetector(
          onTap: () {
            // Github auth
          },
          child: SvgPicture.asset(
            'assets/icons/github.svg',
            width: 40,
          ),
        ),
      ],
    );
  }
}
