import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/constants/validators.dart';
import 'package:techconvene/models/event_model.dart';
import 'package:techconvene/router/route_names.dart';

class EventForm extends StatefulWidget {
  EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final TextEditingController _eventName = TextEditingController();

  final TextEditingController _description = TextEditingController();


  final TextEditingController _prizes = TextEditingController();

  final TextEditingController _pincode = TextEditingController();
  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  DateTime? selectedDate1;

  DateTime? selectedDate2;

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
        _start.text = selectedDate1.toString().split(" ").first;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
        _end.text = selectedDate2.toString().split(" ").first;
      });
    }
  }

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
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate1(context),
                      child: Text('Start Date'),
                    ),
                    MyTextField(
                      label: "Start Date",
                      controller: _start,
                      readOnly: true,
                      width: 150,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate2(context),
                      child: Text('End Date'),
                    ),
                    MyTextField(
                      label: "End Date",
                      controller: _end,
                      readOnly: true,
                      width: 150,
                    )
                  ],
                ),
                MyTextField(
                  label: "Prizes",
                  controller: _prizes,
                ),
                MyTextField(
                  label: "Pincode",
                  controller: _pincode,
                  // validate: MyValidators
                ),
                PrimaryBtn(
                    label: "Continue",
                    onpress: () {
                      if (_formkey.currentState!.validate()) {
                        EventModel eventModel = EventModel(
                          eventname: _eventName.text.toString(),
            
                          prizes: _prizes.text.toString(),
                          description: _description.text.toString(),
                          posterUrl: "",
                          uid: "",
                          isClosed:  false,
                          location: _pincode.text.toString(),
                          eventMode: "",
                          startDate: selectedDate1,
                          endDate: selectedDate2,
                        );
                        // Map<String, dynamic> eventdata = {
                        //   "eventname": _eventName.text.toString(),
                        //   "description": _description.text.toString(),
                        //   "eventDate": _date.text.toString(),
                        //   "prizes": _prizes.text.toString(),
                        //   "location": _pincode.text.toString(),
                        //   "startDate": selectedDate1,
                        //   "endDate": selectedDate2,
                        //   "club": "club"
                        // };

                        Get.toNamed(RoutesNames.selectposter,
                            arguments: eventModel);
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
