import 'dart:io';

import 'package:get/get.dart';

class FileController extends GetxController {
  File? poster;

  void saveImage(File img) async {
    poster = img;
    update();
  }

  File? getImage() {
    return poster;
  }

  @override
  void onClose() {
    poster = null;

    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    poster = null;
    super.dispose();
  }
}
