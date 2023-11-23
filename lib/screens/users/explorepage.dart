import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/models/user_model.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/events/event_services.dart';
import 'package:techconvene/services/users/users_db.dart';

class RegisteredEventsPage extends StatelessWidget {
  const RegisteredEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Events"),
        centerTitle: true,
      leading: Container(),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: FutureBuilder<List<EventModel>>(
      future: fetchEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Column(
mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("You have not participated in any event"),
            SizedBox(height: 20,),
              Container(
                      width: width * 0.9,
                      height: width * 0.5,
                      child: Lottie.network("https://lottie.host/fbf90ddf-575c-4c69-aa6d-6a9415f9fb8d/P6O4uXw0wN.json"),
                    ),
            ],
          ),);
          
        } else {
           return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              EventModel event = snapshot.data![index];
              return EventListItem(event: event);
            },
          );
        }
      },
    ),
      ),
    );
  }

   Future<List<EventModel>> fetchEvents() async {
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
            bool res = await EventService.unregisterUserFromEvent(event.uid, FirebaseAuth.instance.currentUser!.uid);
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
