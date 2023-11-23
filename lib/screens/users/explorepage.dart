import 'package:flutter/material.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/constants/text_styles.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Events"),
        centerTitle: true,
      leading: Container(),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(children: [
          MyTexts.h3("Top Events"),
          SizedBox(
            height: 20,
          ),
          Container(
            height: height * 0.2,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  color: AppColors.kblue,
                );
              },
            ),
          ),
         const SizedBox(
            height: 20,
          ),
          MyTexts.h3("Nearby College Events"),
          SizedBox(
            height: 20,
          ),
          Container(
            height: height * 0.2,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  color: Colors.yellow,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
