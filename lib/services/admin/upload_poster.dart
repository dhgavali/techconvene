import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Uploading {

  Future<void> requestBothPermissions() async {
  var storageStatus = await Permission.storage.status;
  var cameraStatus = await Permission.camera.status;

  if (storageStatus.isDenied || cameraStatus.isDenied) {
    // You can request both permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();
    
    storageStatus = statuses[Permission.storage] ?? PermissionStatus.denied;
    cameraStatus = statuses[Permission.camera] ?? PermissionStatus.denied;
  }

  if (storageStatus.isGranted && cameraStatus.isGranted) {
    // Permissions granted for both
  } else {
    // Permissions denied for one or both
  }
}

  Future<File?> uploadImage() async {
    //Check Permissions
     PermissionStatus? storagepermission;
    PermissionStatus? photopermission;
    if(Platform.isIOS){
      await   requestBothPermissions();
    }
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        storagepermission = await Permission.storage.status;
      } else {
        photopermission = await Permission.photos.status;
      }
    }
    if (storagepermission == null || photopermission!.isGranted) {
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
