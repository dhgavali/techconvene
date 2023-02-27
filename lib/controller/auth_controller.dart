import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/admin/admin_db.dart';
import 'package:techconvene/services/auth.dart';
import 'package:techconvene/shared/SharedData.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  var isLoading = false.obs;
  // Rx<bool> isLoggedIn = false.obs;
  late String email;
  late String password;
  late String fullname;

  // login controller
  Future<void> login(BuildContext context) async {
    try {
      isLoading.value = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      await AuthMethods().signIn(
        context: context,
        email: email,
        password: password,
      );

      await SharedData.saveRole("user");
      Get.offAllNamed(RoutesNames.landingPage);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> signup(BuildContext context) async {
    try {
      isLoading.value = true;
      update();

      await AuthMethods().signUp(
        context: context,
        email: email,
        fullname: fullname,
        password: password,
      );
      Get.offAllNamed(RoutesNames.loginScreen);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void logout() {
    // isLoggedIn.value = false;
  }

  // hostlogin

  Future<void> hostLogin(BuildContext context) async {
    try {
      isLoading.value = true;
      update();
      print("priting mail : $email");
      bool res = await AdminDb.getHost(email);
      if (res) {
        UserCredential? user = await AuthMethods().signIn(
          context: context,
          email: email,
          password: password,
        );

        await SharedData.saveRole("admin");
        String? data = await SharedData.getRole();
        print(data);
        Get.offAllNamed(RoutesNames.adminLanding);
      } else {
        print("Admin not present");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // host signup methods
  Future<void> hostSignUp(
      BuildContext context, Map<String, dynamic> hostdata) async {
    try {
      isLoading.value = true;
      update();
      UserCredential? user = await AuthMethods().signUp(
        context: context,
        email: email,
        password: password,
        fullname: fullname,
      );

      if (user != null) {
        // print("host is not null");
        hostdata["uid"] = user.user!.uid;
        await AdminDb.addUser(hostdata);
      } else {
        print("host null");
      }

      Get.offAllNamed(RoutesNames.hostlogin);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
