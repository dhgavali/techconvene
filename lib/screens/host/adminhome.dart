import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/services/admin/admin_db.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 20.h,
            ),
            child: Column(
              children: [
                Container(
                  child: MyTexts.h2("Ongoing Events"),
                ),
                SizedBox(
                  height: width * 0.3,
                  child: FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: width * 0.4,
                              height: width * 0.2,
                              margin: const EdgeInsets.all(10),
                              color: AppColors.btmNavColor,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  child: MyTexts.h2("Past Events"),
                ),
                SizedBox(
                  height: width * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: width * 0.4,
                        height: width * 0.2,
                        margin: const EdgeInsets.all(10),
                        color: AppColors.btmNavColor,
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
