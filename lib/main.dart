import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techconvene/constants/colors.dart';
import 'package:techconvene/router/route_names.dart';
import 'package:techconvene/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 840),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          defaultTransition: Transition.leftToRight,
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesNames.authPage,
          getPages: AppRoutes.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Poppins",
            appBarTheme: AppBarTheme(backgroundColor: AppColors.darkBlueColor),
          ),
        );
      },
    );
  }
}


// TODO: Try this
// firebase_ui_firestore: ^1.2.8