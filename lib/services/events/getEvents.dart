import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/event_model.dart';

class EventService {
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
    // return snapshot.docs.map(( e) => EventModel.fromJson(e.data())).toList();

    // return snapshot.docs
    //     .map((docSnapshot) => EventModel.fromJson(docSnapshot)
    // .toList();
  }
}
