import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/models/event_model.dart';

class EventScreen extends StatelessWidget {
  // final EventModel eventModel;
  const EventScreen({super.key});
  @override
  Widget build(BuildContext context) {
    EventModel data = Get.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                data.posterUrl,
              ),
              width: size.width * 0.9,
              height: size.width * 0.5,
            ),
          ],
        ),
      )),
    );
  }
}
