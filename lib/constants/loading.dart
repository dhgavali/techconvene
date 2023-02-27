import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techconvene/constants/colors.dart';

class Loadings {
  static Widget basic() {
    return SpinKitDancingSquare(
      color: Color.fromARGB(255, 7, 1, 114),
      size: 50.0,
    );
  }
}
