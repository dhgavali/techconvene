import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/router/route_names.dart';

class EventForm extends StatelessWidget {
  EventForm({super.key});

  TextEditingController _eventName = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _prizes = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTexts.h2("Basic Details"),
              MyTextField(
                label: "Event Name",
                controller: _eventName,
              ),
              MyTextField(
                label: "Description",
                controller: _description,
              ),
              // MyTextField(
              //   label: "Location",
              //   controller: TextEditingController(),
              // ),
              MyTextField(
                label: "Date",
                controller: _date,
              ),
              MyTextField(
                label: "Prizes",
                controller: _prizes,
              ),
              MyTextField(
                label: "Pincode",
                controller: _pincode,
              ),
              PrimaryBtn(
                  label: "Continue",
                  onpress: () {
                    Map<String, dynamic> eventdata = {
                      "eventname": _eventName.text.toString(),
                      "description": _description.text.toString(),
                      "date": _date.text.toString(),
                      "_prizes": _prizes.text.toString(),
                      "pincode": _pincode.text.toString(),
                    };
                    Get.toNamed(RoutesNames.selectposter, arguments: eventdata);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
