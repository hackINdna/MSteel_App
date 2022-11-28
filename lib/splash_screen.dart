import 'dart:async';
import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/login.dart';

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
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 132),
                child: Text(
                  "My Steel",
                  textScaleFactor: 3.2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: headingColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Copyright \u00a9 Technlogi.com",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
