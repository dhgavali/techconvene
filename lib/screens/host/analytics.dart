import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/models/user_model.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/screens/host/users_analytics.dart';
import 'package:techconvene/services/events/event_services.dart';
import 'package:techconvene/services/users/users_db.dart';

class EventAnalytics extends StatelessWidget {
  const EventAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
        centerTitle: true,
      leading: Container(),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
              children: [
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
                              print("Event data ${data.uid}" );
                              return GestureDetector(
                                onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=> UserAnalytics(participantIds: data.participants)));
                                },
                                child: Container(
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
                                              MyTexts.h4("Start date: ${data.startDate.toString().split(" ").first}"),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                             
                                              SizedBox(
                                                width: 5.h,
                                              ),
                                              MyTexts.h4("Total Participants: ${data.participants!.length ?? '0'}"),
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
                          return Center(
                            child: Loadings.basic(),
                          );
                        }
                      } else {
                        return Center(
                          child: Loadings.basic(),
                        );
                      }
                    },
                  ),
                ),
                
              ],
            )),
      
    );
  }

   Future<List<EventModel>> fetchHostEvents() async {
    List<EventModel> events = [];
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    UserModel? userData = await UsersDb.getUserData(currentUserUid);

if (userData != null && userData.eventParticipated != null) {
      for (String? eventId in userData.eventParticipated!) {
        DocumentReference eventRef = FirebaseFirestore.instance.collection('event').doc(eventId!.trim());

        DocumentSnapshot eventSnapshot = await eventRef.get();
        if (eventSnapshot.exists) {
          Map<String, dynamic> eventData = eventSnapshot.data() as Map<String, dynamic>;
          EventModel eventModel = EventModel.fromJson(eventData);
          events.add(eventModel);
        }
      }
    }

    return events;
  }
}


class EventListItem extends StatelessWidget {
  final EventModel event;

  const EventListItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Text(
          event.eventname,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          event.description,
          style: TextStyle(fontSize: 16.0),
        ),
        leading: Container(
          width: 50,
          height: 100,
          child: Image.network(
            event.posterUrl,
            fit: BoxFit.cover,
          ),  
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            // TODO: Implement unregister method
            bool res = await EventService.unregisterUserFromEvent(event.uid!, FirebaseAuth.instance.currentUser!.uid);
            if (res) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unregistered from event successfully")));
            Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to unregister from the event")));
            }
          },
          child: Text("Unregister"),
        ),
      ),
    );
  }
}
