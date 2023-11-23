import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/models/user_model.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/auth.dart';
import 'package:techconvene/services/users/users_db.dart';

class ProfilePage extends StatelessWidget { 
  final TextEditingController nameController = TextEditingController();
        final TextEditingController bioController = TextEditingController();


  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:

          AppBar(
             title: const Text("Profile Page"),
             elevation: 0, 
          
          actions: [
        Center(
          child: IconButton(
          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await AuthMethods().signOut();
                                          },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        )
      ]),
      floatingActionButton: ElevatedButton(
  onPressed: () {

    showDialog(
      context: context,
      builder: (BuildContext context) {
          BuildContext alertDialogContext = context;
       
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: bioController,
                decoration: InputDecoration(labelText: 'bio'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
           

              bool res =  await UsersDb.updateUserData({"uid" : FirebaseAuth.instance.currentUser!.uid, "name": nameController.text, "bio" : bioController.text});
           if (res) {
  

              Navigator.pop(context); // Close the AlertDialog
              Get.offAndToNamed(RoutesNames.profilePage);
            } else {
              
           
              Navigator.pop(context); // Close the AlertDialog
            }
          },
              child: const Text('Save'),
            ),
            OutlinedButton(onPressed: (){
                Navigator.pop(context);
            }, child: const Text("Cancel"))
          ],
        );
      },
    );
  },
  child: Text('Edit Profile'),
),
      body: Container(
        width: width,
       child: FutureBuilder<UserModel?>(
  future: UsersDb.getUserData(FirebaseAuth.instance.currentUser!.uid),
  builder: (context, AsyncSnapshot<UserModel?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData && snapshot.data != null) {
        UserModel user = snapshot.data!;

        nameController.text = user.name;
        bioController.text = user.bio ?? "";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
           const SizedBox(height: 20),
           const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              )
            ),
            SizedBox(height: 20),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
             user.bio?? "--",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Divider(height: 20),
           const ProfileCard(totalEventsParticipated: 20, rank: 5),
          ],
        );
      } else {
        // Handle the case when snapshot has no data or data is null
        return Container();
      }
    } else {
      // Handle the case when the Future is still in progress
      return Loadings.basic();
    }
  },
),

      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final int totalEventsParticipated;
  final int rank;

  const ProfileCard({
    Key? key,
    required this.totalEventsParticipated,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      child: Card(
        elevation: 4.0,
        color: Color.fromARGB(255, 248, 248, 248),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const  Text(
                    'Total Events \n Participated',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
               const   SizedBox(height: 8),
               Text(
                    '$totalEventsParticipated',
                    style: TextStyle(fontSize: 18),
                  ),
                
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const   Text(
                    'Rank',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ), 
               const   SizedBox(height: 8),
               
                    Text(
                    '$rank',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
