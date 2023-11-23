import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techconvene/models/event_model.dart';

class AdminDb {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection("admin");
  static final CollectionReference _eventref =
      FirebaseFirestore.instance.collection("event");

  // add user data on sign up
  static Future<bool> addUser(Map<String, dynamic> data) async {
    try {
      final QuerySnapshot result =
          await _ref.where('email', isEqualTo: data['email']).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        await _ref.doc(data['uid']).set(data);
        return true;
      } else {
        print("already present data");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> getHost(String email) async {
    final QuerySnapshot result =
        await _ref.where('email', isEqualTo: email).get();
    print("docs");
    print(result.docs);
    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getHostProfile() async {
    print("get host profile");
    print(FirebaseAuth.instance.currentUser!.uid);
    QuerySnapshot data = await _ref
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    var obj = data.docs[0].data();
    // print(obj)
    Map<String, dynamic> map = data.docs[0].data() as Map<String, dynamic>;
    // Map<String, dynamic> da = obj;
    return map;
  }


// getting id

static Future<String> getEventId() async{
   return  _eventref.doc().id;
}
static Future<String> getAdminId() async{
   return  _ref.doc().id;
}
  // posting event

  static Future<bool> postEvent(Map<String, dynamic> eventdata) async {
    try {
      print("event data is $eventdata");
      // await _eventref.add(eventdata);
      await _eventref.doc(eventdata['eventId']).set(eventdata);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> storeEventIdInUserCollection(String userId, String eventId) async {
  try {
    await _ref.doc(userId).update({
      'eventLists': FieldValue.arrayUnion([eventId]),
    });
    return true;
  } catch (e) {
    print('Error storing eventId in user collection: $e');
    return false;
  }
}
}



  // Future<List<Employee>> retrieveEmployees() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot =
  //       await _db.collection("Employees").get();
  //   return snapshot.docs
  //       .map((docSnapshot) => Employee.fromDocumentSnapshot(docSnapshot))
  //       .toList();
  // }