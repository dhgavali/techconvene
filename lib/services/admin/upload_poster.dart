import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Uploading {
  Future<File?> uploadImage() async {
    //Check Permissions
    late PermissionStatus storagepermission;
    late PermissionStatus photopermission;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        storagepermission = await Permission.storage.status;
      } else {
        photopermission = await Permission.photos.status;
      }
    }
    if (storagepermission.isGranted || photopermission.isGranted) {
      try {
        ImagePicker imagePicker = ImagePicker();
        XFile? pickedFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 80,
            maxHeight: 800,
            maxWidth: 500);

        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);

          // print(imageFile.path);
          // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          return imageFile;
        } else {
          print("no image selected");
        }
      } on FirebaseException catch (e) {
        print(e.message);
      }
    } else {
      print('Permission not granted. Try Again with permission access');
      await Permission.photos.request();
      await Permission.storage.request();
    }
  }
}
