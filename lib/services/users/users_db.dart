import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDb {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection("users");

  // add user data on sign up
  static Future<bool> addUser(Map<String, dynamic> data) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: data['email'])
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        await _ref.add(data);
        return true;
      } else {
        print("already present data");
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
