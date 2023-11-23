import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techconvene/services/users/users_db.dart';

import '../../models/event_model.dart';

class EventService {
  // returns all events
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection("event");

  static Future<List<EventModel>> getEvents() async {
    QuerySnapshot<Object?> snapshot = await _ref.get();
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
    QuerySnapshot<Object?> snapshot =
        await _ref.where('uid', isEqualTo: hostid).get();
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

//register user for an event
  static Future<bool> registerUserForEvent(String eventId, String userId) async {
    try {
      // Reference to the specific event document
      DocumentReference eventRef = _ref.doc(eventId.trim());
print(eventRef.id.trim());
      // Update the participants field by adding the user ID to the array
      await eventRef.update({
        'participants': FieldValue.arrayUnion([userId]),
      });

      await UsersDb.registerUserForEvent(eventId, userId);
    

      print('User $userId registered for event $eventId successfully.');
      return true;
    } catch (e) {
      print('Error registering user for event: $e');
      return false;
      // Handle error as needed
    }
  }

  //remover user from an event
  static Future<bool> unregisterUserFromEvent(String eventId, String userId) async {
    try {
      // Reference to the specific event document
      DocumentReference eventRef = _ref.doc(eventId.trim());

      // Update the participants field by removing the user ID from the array
      await eventRef.update({
        'participants': FieldValue.arrayRemove([userId]),
      });
       await UsersDb.unRegisterUserForEvent(eventId, userId);
      print('User $userId unregistered from event $eventId successfully.');
      return true;
    } catch (e) {
      print('Error unregistering user from event: $e');
      return false;
      // Handle error as needed
    }
  }








  // update event

    //delete event
}
