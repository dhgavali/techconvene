import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                minRadius: 25.h,
                maxRadius: 25.h,
                backgroundColor: Colors.red,
              )
              // backgroundImage:              ),
              ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: isloading
              ? Loadings.basic()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await AuthMethods().signOut();
                          // setState(() {
                          //   isloading = !isloading;
                          // });
                          Get.offAllNamed(RoutesNames.loginScreen);
                        },
                        child: Text("Logout")),
                    const Text(
                      "homeapge",
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
