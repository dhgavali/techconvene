import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/models/event_model.dart';

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
        onPressed: () {
          // TODO: Navigate to Event URl
        },
        child: Text("Register"),
      ),
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
              label: data.eventMode,
              subtitle: "Mode",
              icon: Icons.location_on,
            ),
            eventDetailRow(
              label: data.location,
              subtitle: "Locations",
              icon: Icons.location_on,
            ),
            eventDetailRow(
              label: data.prizes,
              subtitle: "Prize",
              icon: Icons.currency_rupee,
            ),
            eventDetailRow(
              label: data.eventDate,
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
