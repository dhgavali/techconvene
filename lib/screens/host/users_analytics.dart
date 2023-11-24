import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techconvene/models/user_model.dart';

class UserAnalytics extends StatefulWidget {
  final List<String?>? participantIds;

  UserAnalytics({required this.participantIds});

  @override
  _UserAnalyticsState createState() => _UserAnalyticsState();
}

class _UserAnalyticsState extends State<UserAnalytics> {
   List<UserModel>? participantsData;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the screen is initialized
    fetchParticipantsData();
  }

  Future<void> fetchParticipantsData() async {
    List<UserModel> participantsList = [];

    // Fetch user data for each participant
    for (String? userId in widget.participantIds!) {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

       
    
        participantsList.add(UserModel.fromJson(userData));
      }
    }

    setState(() {
      participantsData = participantsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
      ),
      body: participantsData != null
          ? ListView.builder(
              itemCount: participantsData!.length,
              itemBuilder: (context, index) {
                UserModel user = participantsData![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.emailId),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
