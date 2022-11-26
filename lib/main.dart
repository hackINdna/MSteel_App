import "package:flutter/material.dart";
import 'package:m_steel/widgets/login.dart';
import 'package:m_steel/widgets/splash_screen.dart';

void main() {
  runApp(const TheApplication());
}

class TheApplication extends StatelessWidget {
  const TheApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "DMSans",
      ),
      routes: {
        "/": (context) => const SplashScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
    );
  }
}
