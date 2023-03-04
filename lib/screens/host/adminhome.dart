import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/services/events/event_services.dart';

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
                Expanded(
                  child: FutureBuilder<List<EventModel>>(
                    future: EventService.getHostEvents(
                      hostid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<EventModel>? events = snapshot.data;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: events!.length,
                            itemBuilder: (BuildContext context, int index) {
                              EventModel data = events[index];
                              return Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.8,
                                height: width * 0.4,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 35.h,
                                    ),
                                    Image.network(
                                      data.posterUrl,
                                      width: width * 0.15,
                                    ),
                                    SizedBox(
                                      width: 35.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        MyTexts.h2(data.eventname),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.calendar_month),
                                            SizedBox(
                                              width: 5.h,
                                            ),
                                            MyTexts.h4(data.eventDate),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.currency_rupee),
                                            SizedBox(
                                              width: 5.h,
                                            ),
                                            MyTexts.h4(data.prizes),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
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
