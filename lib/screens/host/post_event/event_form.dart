import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/constants/validators.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/router/route_names.dart';

class EventForm extends StatelessWidget {
  EventForm({super.key});

  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _prizes = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTexts.h2("Basic Details"),
                MyTextField(
                  label: "Event Name",
                  controller: _eventName,
                  validate: MyValidators.v_name,
                ),
                MyTextField(
                  label: "Description",
                  controller: _description,
                  validate: MyValidators.v_name,
                ),
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
                  // validate: MyValidators,
                ),
                PrimaryBtn(
                    label: "Continue",
                    onpress: () {
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> eventdata = {
                          "eventname": _eventName.text.toString(),
                          "description": _description.text.toString(),
                          "eventDate": _date.text.toString(),
                          "prizes": _prizes.text.toString(),
                          "location": _pincode.text.toString(),
                          "club": "abc",
                        };

                        
                        Get.toNamed(RoutesNames.selectposter,
                            arguments: eventdata);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
