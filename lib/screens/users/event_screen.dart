import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/services/events/event_services.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});
  @override
  Widget build(BuildContext context) {
    EventModel data = Get.arguments;
    Size size = MediaQuery.of(context).size;
    print(data.posterUrl);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
  onPressed: () async {
    // TODO: Navigate to Event URL
    print("button clicked ${data.participants}");

    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    if (data.participants != null && data.participants!.contains(currentUserUid)) {
      // User has already participated, show a message or handle accordingly
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already registered for the event!")));
    } else {
      // User has not participated, proceed with registration
      bool res = await EventService.registerUserForEvent(data.uid!, currentUserUid);

      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered for the event successfully")));
        Get.offAndToNamed(RoutesNames.landingPage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to register for the event!")));
      }
    }
  },
  child: Text(data.participants != null && data.participants!.contains(FirebaseAuth.instance.currentUser!.uid)
      ? "Already Registered"
      : "Register"),
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.grey.shade800;
      } else if (data.participants != null && data.participants!.contains(FirebaseAuth.instance.currentUser!.uid)) {
     
        return Colors.grey.shade800;
      } else {
        
        return Colors.blue;
      }
    }),
))

,

      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.7,
              color: Colors.transparent,
              child: Image(
                image: NetworkImage(data.posterUrl),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(
                10,
              ),
              alignment: Alignment.center,
              child: MyTexts.h1(data.eventname),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              alignment: Alignment.centerLeft,
              child: MyTexts.h4(
                data.description,
              ),
            ),
            eventDetailRow(
              label: data.eventMode ?? "Online",
              subtitle: "Mode",
              icon: Icons.location_on,
            ),
            eventDetailRow(
              label: data.location,
              subtitle: "Locations",
              icon: Icons.location_on,
            ),
            eventDetailRow(
              label: data.prizes ?? "-",
              subtitle: "Prize",
              icon: Icons.currency_rupee,
            ),
            eventDetailRow(
              label: data.startDate.toString().split(" ").first,
              subtitle: "Date",
              icon: Icons.calendar_month,
            ),
            Container(
              alignment: Alignment.center,
              child: MyTexts.h2(
                "Social Links",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    "assets/icons/instagram.svg",
                    width: 40,
                  ),
                  SvgPicture.asset(
                    "assets/icons/website.svg",
                    width: 40,
                  ),
                  SvgPicture.asset(
                    "assets/icons/website.svg",
                    width: 40,
                  ),
                  SvgPicture.asset(
                    "assets/icons/google.svg",
                    width: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      )),
    );
  }
}

class eventDetailRow extends StatelessWidget {
  eventDetailRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.subtitle,
  }) : super(key: key);

  final String label;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10.h,
          ),
          MyTexts.h4("$subtitle :  ${label}"),
        ],
      ),
    );
  }
}
