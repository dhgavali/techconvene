import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/event_model.dart';

class EventService {
  // returns all events
  static Future<List<EventModel>> getEvents() async {
    CollectionReference db = FirebaseFirestore.instance.collection("event");
    QuerySnapshot<Object?> snapshot = await db.get();
    List<EventModel> events = [];
    // print(snapshot.docs[0].data());
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        Map<String, dynamic> d = {};
        d = element.data() as Map<String, dynamic>;
        events.add(EventModel.fromJson(d));
      }
      return events;
    } else {
      return [];
    }
  }

  // returns only admin specific events
  static Future<List<EventModel>> getHostEvents(
      {required String hostid}) async {
    CollectionReference db = FirebaseFirestore.instance.collection("event");
    QuerySnapshot<Object?> snapshot =
        await db.where('uid', isEqualTo: hostid).get();
    List<EventModel> events = [];

    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        Map<String, dynamic> d = {};
        d = element.data() as Map<String, dynamic>;
        events.add(EventModel.fromJson(d));
      }
      return events;
    } else {
      return [];
    }
  }
}
