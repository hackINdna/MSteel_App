import 'dart:async';
import 'package:flutter/material.dart';
import 'package:m_steel/authScreen/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data_models/notification_app.dart';

//Splash
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splash bg.jpg",
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/msteel_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 132),
              //   child: Text(
              //     "My Steel",
              //     textScaleFactor: 3.2,
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: headingColor,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 30),
              //   child: Text(
              //     "Copyright \u00a9 Technlogi.com",
              //     style: TextStyle(fontWeight: FontWeight.w500),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
