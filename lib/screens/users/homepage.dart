
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/services/events/event_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "On Going Events",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              minRadius: 25.h,
              maxRadius: 25.h,
              backgroundColor: Colors.red,
              // foregroundImage: FirebaseAuth.instance.currentUser!.photoURL !=
              //         null
              //     ? NetworkImage(
              //         FirebaseAuth.instance.currentUser!.photoURL.toString())
              //     : null,
              backgroundImage: AssetImage("assets/icons/profile.png"),
            ),

            // backgroundImage:              ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: isloading
              ? Loadings.basic()
              : FutureBuilder<List<EventModel>>(
                  future: EventService.getEvents(),
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
                            return GestureDetector(
                              onTap: () {
                                
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.4,
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
                                      width: width * 0.2,
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
      ),
    );
  }
}
