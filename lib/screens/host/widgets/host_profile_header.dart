import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostProfileHeader extends StatelessWidget {
  const HostProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          width: width * 0.4,
          child: const ListTile(
            title: Text("2"),
            subtitle: Text("Total Events Hosted"),
          ),
        ),
        Container(
          width: width * 0.4,
          child: const ListTile(
            title: Text("4000+"),
            subtitle: Text("Participants"),
          ),
        ),
      ],
    );
  }
}
