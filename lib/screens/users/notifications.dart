import 'package:flutter/material.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: Colors.grey.shade200,
                          )
                        ]),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTexts.h3("Notification $index"),
                            MyTexts.h4(
                                "The time for the event has been extended. Hurry up and submit your reponse tommorow"),
                          ]),
                    ),
                  ),
                );
              },
            );
          } else {
            return Loadings.basic();
          }
        },
      )),
    );
  }
}

Widget _noNotifs() {
  return Center(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.notifications_active_outlined,
        size: 72,
        color: AppColors.darkBlueColor,
      ),
      SizedBox(
        height: 30,
      ),
      MyTexts.h3("You don't have any new notifications"),
    ],
  ));
}
