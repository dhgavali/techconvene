import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/services/admin/admin_db.dart';

class HostProfile extends StatelessWidget {
  const HostProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: FutureBuilder(
            future: AdminDb.getHostProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTexts.h2("Name : ${data['fullname']}"),
                    MyTexts.h2("Position: ${data['position']}"),
                    MyTexts.h2("Email: ${data['email']}"),
                    MyTexts.h2("Mobile: ${data['mobile']}"),
                    MyTexts.h2("Club: ${data['club']}"),
                    MyTexts.h2("City: ${data['city']}"),
                  ],
                );
              }
              return Center(child: Loadings.basic());
            },
          ),
        ),
      ),
    );
  }
}
