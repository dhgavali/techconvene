import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/constants/validators.dart';
import 'package:techconvene/controller/auth_controller.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/screens/auth/widgets/auth_label_widget.dart';
import 'package:techconvene/screens/widgets/auth_widgets.dart';

class HostSignupScreen extends StatelessWidget {
  HostSignupScreen({super.key});

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _club = TextEditingController();
  final TextEditingController _position = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _cnfpass = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
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
                              MyTexts.h2(
                                  "Register with us and \nPromote your events !"),
                              SizedBox(
                                height: 40.h,
                              ),
                              MyTextField(
                                label: "Full Name",
                                controller: _fullname,
                              ),
                              MyTextField(
                                label: "Organization/Club/College Name",
                                controller: _club,
                              ),
                              MyTextField(
                                label: "Your Position",
                                controller: _position,
                              ),
                              MyTextField(
                                label: "Email id",
                                controller: _email,
                                validate: MyValidators.v_email,
                                keytype: TextInputType.emailAddress,
                              ),
                              MyTextField(
                                label: "Mobile No.",
                                controller: _mobile,
                                digitsonly: true,
                                keytype: TextInputType.phone,
                                maxlen: 10,
                              ),
                              MyTextField(
                                label: "City",
                                controller: _city,
                              ),
                              MyTextField(
                                label: "Pincode",
                                controller: _pincode,
                                keytype: TextInputType.phone,
                                maxlen: 6,
                              ),
                              MyTextField(
                                label: "Password",
                                ispassword: true,
                                controller: _pass,
                              ),
                              MyTextField(
                                  label: "Confirm Password",
                                  ispassword: true,
                                  controller: _cnfpass),
                              SizedBox(
                                height: 10.h,
                              ),
                              PrimaryBtn(
                                label: "Sign Up",
                                onpress: () async {
                                  if (_formkey.currentState!.validate()) {
                                    controller.email = _email.text.trim();
                                    controller.password = _pass.text.trim();
                                    controller.fullname = _fullname.text;
                                    Map<String, dynamic> hostdata = {
                                      "fullname": _fullname.text.trim(),
                                      "club": _club.text.trim(),
                                      "position": _position.text.trim(),
                                      "email": _email.text.trim(),
                                      "mobile": _mobile.text,
                                      "city": _city.text,
                                      "pincode": _pincode.text,
                                    };
                                    // print(hostdata);
                                    await controller.hostSignUp(
                                        context, hostdata);
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
                                label1: "Already have account ? ",
                                label2: "LOGIN HERE",
                                onpress: () {
                                  Get.toNamed(RoutesNames.hostlogin);
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
