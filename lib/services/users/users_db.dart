import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techconvene/models/user_model.dart';

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




static Future<UserModel?> getUserData(String userid) async {
  try {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: userid)
        .get();

    final List<QueryDocumentSnapshot> documents = result.docs;
    if (documents.isEmpty) {
      return null;
    } else {
      final Map<String, dynamic> userData = documents.first.data() as Map<String, dynamic>;

      // Use the fromJson factory method to create a UserModel object
      return UserModel.fromJson(userData);
    }
  } catch (e) {
    print("Error fetching user data: $e");
    return null;
  }
}

 static Future<bool> updateUserData(Map<String, dynamic> data) async {
    try {
      // Query for the document with the given UID
      QuerySnapshot querySnapshot = await _ref.where('uid', isEqualTo: data['uid']).get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        // Update the document with the new data
        await userDocRef.update(data);

        // Update successful
        return true;
      } else {
        // Document not found
        return false;
      }
    } catch (e) {
      // Handle errors
      print("Error updating user data: $e");
      return false;
    }
  }


   static Future<bool> registerUserForEvent(String eventId, String userId) async {
    try {
      // Reference to the specific event document
      DocumentReference eventRef = _ref.doc(userId.trim());

      // Update the participants field by adding the user ID to the array
      await eventRef.update({
        'eventParticipated': FieldValue.arrayUnion([eventId]),
      });

      print('User $userId registered for event $eventId successfully.');
      return true;
    } catch (e) {
      print('Error registering user for event: $e');
      return false;
      // Handle error as needed
    }
  }


   static Future<bool> unRegisterUserForEvent(String eventId, String userId) async {
    try {
      // Reference to the specific event document
      DocumentReference eventRef = _ref.doc(userId.trim());

      // Update the participants field by adding the user ID to the array
      await eventRef.update({
        'eventParticipated': FieldValue.arrayRemove([eventId]),
      });

      print('User $userId registered for event $eventId successfully.');
      return true;
    } catch (e) {
      print('Error registering user for event: $e');
      return false;
      // Handle error as needed
    }
  }
}

