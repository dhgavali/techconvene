import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/screens/users/event_screen.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});
  @override
  Widget build(BuildContext context) {
    EventModel data = Get.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
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
              child: MyTexts.h1("Event Analytics"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  alignment: Alignment.center,
                  child: MyTexts.h3("Total Views: 850"),
                ),
                Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  alignment: Alignment.center,
                  child: MyTexts.h3("Total Likes: 50"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  alignment: Alignment.center,
                  child: MyTexts.h3("Total Registrations: 200"),
                ),
                Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  alignment: Alignment.center,
                  child: MyTexts.h3("Queries: 5"),
                ),
              ],
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(
                10,
              ),
              alignment: Alignment.center,
              child: MyTexts.h1(data.eventname),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
