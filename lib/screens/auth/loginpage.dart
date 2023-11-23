import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/controller/auth_controller.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/screens/auth/widgets/auth_label_widget.dart';
import 'package:techconvene/screens/widgets/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          MyTexts.h1("Welcome Back !!"),
                          MyTexts.h2("Login"),
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
                              
                                await controller.login(context);
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const AuthIcons(),
                          SizedBox(
                            height: 20.h,
                          ),
                          AuthLabelWidget(
                            label1: "Don't Have an account ?",
                            label2: "Sign Up",
                            onpress: () {
                              Get.offAllNamed(
                                RoutesNames.signupScreen,
                              );
                            },
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
