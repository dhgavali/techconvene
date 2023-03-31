import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/controller/auth_controller.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/auth.dart';
import 'package:techconvene/services/users/users_db.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: AppColors.bgWhite, elevation: 0, actions: [
        Center(
          child: IconButton(
            onPressed: () async {
              //
              UsersDb.getUserData("dhiraj@gmail.com");
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.black,
            ),
          ),
        )
      ]),
      body: Container(
        width: width,
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Flutter Developer',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(height: 20),
                    ProfileCard(totalEventsParticipated: 20, rank: 5),
                  ],
                );
              } else {
                return Loadings.basic();
              }
            } else {
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
        color: AppColors.greyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$totalEventsParticipated',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Events \n Participated',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$rank',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rank',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
