import "package:flutter/material.dart";
import 'package:m_steel/forgot_password.dart';
import 'package:m_steel/login.dart';
import 'package:m_steel/otp_verification.dart';
import 'package:m_steel/signup.dart';
import 'package:m_steel/splash_screen.dart';
import 'package:m_steel/welcome.dart';

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
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        fontFamily: "DMSans",
      ),
      routes: {
        "/": (context) => const SplashScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        ForgotPasswordScreen.routeName: (context) =>
            const ForgotPasswordScreen(),
        OtpVerificationScreen.routeName: (context) =>
            const OtpVerificationScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
      },
    );
  }
}
