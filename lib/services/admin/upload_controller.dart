import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;
  RxDouble uploadProgress = 0.0.obs;

  Future<String> uploadImage(File image) async {
    // Create a unique file name for the image
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Create a reference to the file in Firebase Storage
    final Reference reference = storage.ref().child('images/$fileName.jpg');

    // Upload the file to Firebase Storage
    final UploadTask uploadTask = reference.putFile(image);

    // Listen for state changes, errors, and completion of the upload
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      // Calculate the upload percentage and update the progress variable
      final double percentage = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      uploadProgress.value = percentage;
      print('Upload percentage: $percentage%');
    }, onError: (Object error) {
      // Handle errors
      print(error);
    }, onDone: () async {
      // Get the download URL of the uploaded image
      final String downloadUrl = await reference.getDownloadURL();
      print('Image uploaded: $downloadUrl');
    });

    // Wait for the upload to complete and return the download URL
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    final String downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  }
}