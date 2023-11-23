import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/controller/loading_controller.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/admin/admin_db.dart';
import 'package:techconvene/services/admin/file_controller.dart';
import 'package:techconvene/services/admin/upload_controller.dart';
import 'package:techconvene/services/admin/upload_poster.dart';

class SelectPoster extends StatefulWidget {
  const SelectPoster({super.key});

  @override
  State<SelectPoster> createState() => _SelectPosterState();
}

class _SelectPosterState extends State<SelectPoster> {
  String? imageUrl;

  final fileController = Get.put(FileController());
  final uploadController = Get.put(UploadController());
final loadingController =Get.put(LoadingController());

  bool isLoading =false;
  @override
  void dispose() {
    // TODO: implement dispose
    fileController.dispose();
    uploadController.dispose();
    super.dispose();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Container(
        width: size.width,
        child: GetBuilder<FileController>(builder: (controller) {
          File? img = controller.getImage();
          return Obx(
          () => loadingController.isLoading.value
              ? Loadings.basic()
               : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    width: size.width * 0.8,
                    height: size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.white),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          spreadRadius: 2,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: img == null
                        ? Image.network('https://i.imgur.com/sUFH1Aq.png')
                        : Image.file(img)),
                PrimaryBtn(
                    label: "Choose Image",
                    onpress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (cx) {
                          // return BottomSheet(onClosing: , builder: builder)
                          return btmChooseWidget(controller, cx);
                        },
                      );
                    }),
                Column(
                  children: [
                    PrimaryBtn(
                        label:
                            "Upload Image ${uploadController.uploadProgress}",
                        bgColor: AppColors.black,
                        onpress: img == null
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Please choose image")));
                              }
                            : () async {
                              loadingController.showLoading();
                              String eventId = await AdminDb.getEventId();

                                final String path =
                                    await uploadController.uploadImage(img);
                                Map<String, dynamic> eventdata = Get.arguments;
                                eventdata['posterUrl'] = path;
                                eventdata['eventId'] = eventId;
                                eventdata['uid'] =
                                    FirebaseAuth.instance.currentUser!.uid;
                               
                               
                                bool res = await AdminDb.postEvent(eventdata);
                                bool res2 = await AdminDb.storeEventIdInUserCollection(eventdata['uid'], eventId);
                                if (res && res2) {
                                  print("successfully uploaded event");
 await Future.delayed(Duration(seconds: 2));

      // Hide loading
      loadingController.hideLoading();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Uploaded Event!")));
                                  // Get.toNamed(RoutesNames.adminHome);
                                   Get.offAllNamed(RoutesNames.adminLanding);

                                } else {
                                  print("failed to uplaod event");
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to  Uploaded Event!")));
                                  await Future.delayed(Duration(seconds: 2));

      // Hide loading
      loadingController.hideLoading();
                                  // Get.toNamed(RoutesNames.adminHome);
                                   Get.offAllNamed(RoutesNames.adminLanding);
                                }

                                // image uplaoding to firebase
                              }),
                  ],
                ),
              ]));
        }),
      )),
    );
  }

  Widget btmChooseWidget(FileController controller, BuildContext cx) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20.h,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              label: Text("Gallary"),
              onPressed: () async {

                File? poster = await Uploading().uploadImage();
                if (poster != null) {
                  controller.saveImage(poster);
                }
                Navigator.pop(cx);
              },
              icon: Icon(Icons.image),
            ),
            TextButton.icon(
              label: Text("Camera"),
              onPressed: () {},
              icon: Icon(Icons.camera),
            ),
          ],
        ));
  }
}
