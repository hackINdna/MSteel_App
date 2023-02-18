import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_steel/authScreen/otp_verification.dart';
import 'package:m_steel/authScreen/welcome.dart';
import 'package:m_steel/constData.dart';
import 'package:m_steel/errhandeling/httpErrorHandel.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Signup User api
  Future<void> signUpUser({
    required BuildContext context,
    required String fullName,
    required String number,
    required String email,
    required String password,
    required String businessType,
    required String zipCode,
    required String city,
    required String state,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();

      http.Response res = await http.post(Uri.parse("$url/user/signup"),
          body: jsonEncode({
            "fullName": fullName,
            "number": "+91$number",
            "email": email,
            "password": password,
            "businessType": businessType,
            "zipCode": zipCode,
            "city": city,
            "state": state,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            navigatorPop() => Navigator.pop(context);
            navigatorPush() =>
                Navigator.pushNamed(context, OtpVerificationScreen.routeName);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)["token"]);
            user.setUser(res.body);
            navigatorPop();
            navigatorPush();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Login api
  Future<void> login({
    required BuildContext context,
    required String number,
    required String password,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token != null || token!.isNotEmpty) {}
    } catch (e) {}
  }

  // OTP verification api
  Future<void> otpVerification({
    required BuildContext context,
    required String otp,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse("$url/user/otpVerification"),
              body: jsonEncode({
                "otp": otp,
                "number": user.user.number,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            print("OTP verified");
            user.setUser(res.body);
            Navigator.pop(context);
            Navigator.pushNamed(context, WelcomeScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Resend OTP api
  Future<void> resendOTP({
    required BuildContext context,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      print(user.user.number);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");

      if (token != null && token.isNotEmpty) {
        http.Response res = await http.post(Uri.parse("$url/user/resendOTP"),
            body: jsonEncode({"number": user.user.number}),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": token,
            });

        httpErrorHandel(
            context: context,
            res: res,
            onSuccess: () {
              Navigator.pop(context);
              showSnackBar(context, "OTP Sent");
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
