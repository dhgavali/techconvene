import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/controller/auth_controller.dart';
import 'package:techconvene/models/user_model.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/screens/auth/widgets/auth_label_widget.dart';
import 'package:techconvene/screens/widgets/auth_widgets.dart';
import 'package:techconvene/services/users/users_db.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cnfpass = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              MyTexts.h1("Create Account !"),
                              SizedBox(
                                height: 40.h,
                              ),
                              MyTextField(
                                label: "Full Name",
                                controller: _fullname,
                              ),
                              MyTextField(
                                label: "Email id",
                                controller: _email,
                              ),
                              MyTextField(
                                label: "Mobile No.",
                                controller: _mobile,
                                keytype: TextInputType.phone,
                              ),
                              MyTextField(
                                label: "Password",
                                ispassword: true,
                                controller: _password,
                              ),
                              MyTextField(
                                label: "Confirm Password",
                                ispassword: true,
                                controller: _cnfpass,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              PrimaryBtn(
                                label: "Sign Up",
                                onpress: () async {
                                  if (_formkey.currentState!.validate()) {
                                    controller.email = _email.text.toString();
                                    controller.password =
                                        _password.text.toString();
                                    controller.fullname =
                                        _fullname.text.toString();
                                    try {
                                      Map<String, dynamic> usersdata = {
                                        "email": _email.text
                                            .toString()
                                            .toLowerCase(),
                                        "name": _fullname.text.toString(),
                                        "mobile": _mobile.text,
                                      };
                                      UserModel userModel = UserModel(
                                        uid:
                                            '', // Set uid to an empty string for now; it will be updated after signup
                                        name: _fullname.text.toString(),
                                        emailId: _email.text
                                            .toString()
                                            .toLowerCase(),
                                        mobileNo: _mobile.text,
                                      );

                                      UserCredential? user =
                                          await controller.signup(context);
                                      if (user != null) {
                                        userModel.uid = user.user!.uid;
                                        //  push data to db

                                        bool res =
                                            await UsersDb.addUser(userModel.toJson());
                                        if (res) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Account created Successfullly")));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Account already exists")));
                                        }

                                        // Get.offAllNamed(RoutesNames.loginScreen);
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Failed to sign up")));
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              const AuthIcons(),
                              SizedBox(
                                height: 20.h,
                              ),
                              AuthLabelWidget(
                                label1: "Already a User ? ",
                                label2: "Login",
                                onpress: () {
                                  Get.offAndToNamed(
                                    RoutesNames.loginScreen,
                                  );
                                },
                              ),
                            ]),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
