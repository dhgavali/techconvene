import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/shared/SharedData.dart';
import 'package:techconvene/shared/mysnackbar.dart';

class AuthMethods {
  // google sign in
  Future<UserCredential?> signInWithGoogle({ishost = false}) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      try {
        UserCredential firebaseUser =
            await FirebaseAuth.instance.signInWithCredential(credential);
// storing data in shared pref
        await SharedData.saveRole("user");
        return firebaseUser;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

//sign in with email and password

  Future<UserCredential?> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          MyWidgets.showSnackbar(msg: "Email Already in Use", context: context);
          break;
        case "user-not-found":
          MyWidgets.showSnackbar(
              msg: "Account Does not Exists", context: context);
          break;
      }
    }
  }

// sign up with email and password
  Future<UserCredential?> signUp({
    required BuildContext context,
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      if (e.code == 'network-request-failed') {
        MyWidgets.showSnackbar(msg: "No Internet Connection", context: context);
      }
      if (e.code == 'email-already-in-use') {
        MyWidgets.showSnackbar(
            msg: "Account Exists Already!! Please Login", context: context);
      }
      if (e.code == 'invalid-email') {
        MyWidgets.showSnackbar(msg: "Invalid Email Address", context: context);
      }
      if (e.code == 'weak-password') {
        MyWidgets.showSnackbar(msg: "Weak Password", context: context);
      }
    }
  }

// Sign out method
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await SharedData.saveRole("");
      Get.offAllNamed(RoutesNames.onboard,);
    } catch (e) {
      // print(e.toString());
    }
  }
}
