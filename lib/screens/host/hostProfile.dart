import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techconvene/constants/buttons.dart';
import 'package:techconvene/constants/loading.dart';
import 'package:techconvene/constants/text_field.dart';
import 'package:techconvene/constants/text_styles.dart';
import 'package:techconvene/screens/host/widgets/host_profile_header.dart';
import 'package:techconvene/services/admin/admin_db.dart';
import 'package:techconvene/services/auth.dart';

class HostProfile extends StatelessWidget {
  const HostProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: FutureBuilder(
            future: AdminDb.getHostProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTexts.h2("Welcome, ${data['fullname']} !"),
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Logout"),
                                  content: const Text(
                                      "Are you sure you want to logout?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("No"),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await AuthMethods().signOut();
                                        },
                                        child: const Text("Yes")),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ],
                    ),

                    const HostProfileHeader(),
                    const Divider(
                      height: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: MyTexts.h2("User Details"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataRow(
                            data: data['club'], label: "Club / Organization"),
                        DataRow(
                            data: data['position'], label: "Position / Role"),
                        DataRow(data: data['email'], label: "Email Id"),
                        DataRow(data: data['mobile'], label: "Mobile No."),
                        DataRow(data: data['city'], label: "City"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryBtn(
                            label: "Update Details",
                            onpress: () {},
                          )
                        ],
                      ),
                    )

                    // MyTexts.h2("Position: ${data['position']}"),
                    // MyTexts.h2("Email: ${data['email']}"),
                    // MyTexts.h2("Mobile: ${data['mobile']}"),
                    // MyTexts.h2("Club: ${data['club']}"),
                    // MyTexts.h2("City: ${data['city']}"),
                  ],
                );
              }
              return Center(child: Loadings.basic());
            },
          ),
        ),
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  final String data;
  final String label;
  const DataRow({super.key, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
            child: MyTexts.h4(label)),
        MyTextField(
          label: label,
          controller: TextEditingController(),
          initialValue: data,
          readOnly: true,
        ),
      ],
    );
  }
}
