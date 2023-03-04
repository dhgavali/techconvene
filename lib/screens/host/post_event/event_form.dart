// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:techconvene/constants/buttons.dart';
// import 'package:techconvene/constants/colors.dart';
// import 'package:techconvene/constants/text_field.dart';
// import 'package:techconvene/constants/text_styles.dart';
// import 'package:techconvene/constants/validators.dart';
// import 'package:techconvene/models/event_model.dart';
// import 'package:techconvene/router/route_names.dart';
// import 'package:techconvene/screens/host/post_event/step_one.dart';
// import 'package:techconvene/shared/shared_utils.dart';
// import 'package:techconvene/utlis/form_stepper.dart';

// class EventForm extends StatelessWidget {
//   EventForm({super.key});

//   final TextEditingController _eventName = TextEditingController();
//   final TextEditingController _description = TextEditingController();
//   final TextEditingController _date = TextEditingController();
//   final TextEditingController _prizes = TextEditingController();
//   final TextEditingController _pincode = TextEditingController();
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: width,
//           child: FormStepper(
//             stepCount: 3,
//             steps: [
//               Step(
//                 title: Text('Step 1'),
//                 content: Expanded(child: StepOne()),
//               ),
//               Step(
//                 title: Text('Step 2'),
//                 content: Text('Content of step 2'),
//               ),
//               Step(
//                 title: Text('Step 3'),
//                 content: Text('Content of step 3'),
//               ),
//             ],
//             onSubmit: () {
//               // Do something when the form is submitted
//               print('Form submitted');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DateSelector extends StatelessWidget {
//   const DateSelector({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       width: 285.w,
//       height: 50.h,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(15.r),
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(2, 2),
//             color: AppColors.shadowColor,
//             blurRadius: 4.r,
//           ),
//         ],
//       ),
//       margin: EdgeInsets.symmetric(
//         horizontal: 15.w,
//       ),
//       child: TextFormField(
//         cursorColor: AppColors.black,
//         style: MyTextStyles.customStyle(
//           fontsize: 14.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//           border: InputBorder.none,
//           hintText: "Select Date",
//           hintStyle: MyTextStyles.customStyle(
//             fontsize: 14.sp,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
