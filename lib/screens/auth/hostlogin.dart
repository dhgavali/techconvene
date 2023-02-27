import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/controller/auth_controller.dart';
import 'package:techconvene/router/route_names.dart';

class HostLogin extends StatelessWidget {
  HostLogin({super.key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: GetBuilder<AuthController>(
              builder: (controller) => controller.isLoading.value
                  ? Loadings.basic()
                  : Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTexts.h1("Event Organizer Login"),
                          MyTexts.h4(
                              "Promote Events & Reach to large community of evently"),
                          SizedBox(
                            height: 40.h,
                          ),
                          MyTextField(
                            label: "Email id",
                            controller: _username,
                          ),
                          MyTextField(
                            label: "Password",
                            ispassword: true,
                            controller: _password,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 8.h),
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Forgot password Function call
                              },
                              child: MyTexts.h4(
                                "Forgot Password ?",
                              ),
                            ),
                          ),
                          PrimaryBtn(
                            label: "Login",
                            onpress: () async {
                              if (_formkey.currentState!.validate()) {
                                controller.email = _username.text.toString();
                                controller.password = _password.text.toString();

                                await controller.hostLogin(
                                    context);
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          PrimaryBtn(
                            label: "Register with Us",
                            bgColor: AppColors.black,
                            onpress: () {
                              Get.toNamed(RoutesNames.hostsignup);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
