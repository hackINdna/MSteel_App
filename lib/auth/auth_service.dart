import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m_steel/authScreen/otp_verification.dart';
import 'package:m_steel/authScreen/welcome.dart';
import 'package:m_steel/constData.dart';
import 'package:m_steel/errhandeling/httpErrorHandel.dart';
import 'package:m_steel/homePage/home.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/splashScreen/splash_screen.dart';
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
            "fullName": fullName.trim(),
            "number": "+91$number",
            "email": email.trim(),
            // "password": password.trim(),
            "businessType": businessType.trim(),
            "zipCode": zipCode.trim(),
            "city": city.trim(),
            "state": state.trim(),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const OtpVerificationScreen(pageState: "signup");
                }));
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
    // required String password,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      navigatorPop() => Navigator.pop(context);
      navigatorPush() =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const OtpVerificationScreen(pageState: "login");
          }));
      var prefs = await SharedPreferences.getInstance();
      print("url: $url");
      http.Response res = await http.post(Uri.parse("$url/user/loginWithOtp"),
          body: jsonEncode({
            "number": "+91$number",
            // "password": password,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      print("after res");

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);

            // await prefs.setString(
            //     "x-auth-token", jsonDecode(res.body)["token"]);
            navigatorPop();
            navigatorPush();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      Navigator.pop(context);
    }
  }

  // Login with OTP api
  Future<void> loginWithOTP({
    required BuildContext context,
    required String number,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");

      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/user/loginWithOtp"),
          body: jsonEncode({"number": "+91$number"}),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              OtpVerificationScreen.routeName,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // OTP verification api
  Future<void> otpVerification({
    required BuildContext context,
    required String otp,
    required String pageState,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);

      navigatorPop() => Navigator.pop(context);

      navigatorPush(String pageName) => Navigator.pushNamedAndRemoveUntil(
          context, pageName, (route) => false);
      var prefs = await SharedPreferences.getInstance();
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
          onSuccess: () async {
            user.setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)["token"]);
            navigatorPop();
            if (pageState == "signup") {
              navigatorPush(WelcomeScreen.routeName);
            } else {
              navigatorPush(HomeScreen.routeName);
            }
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

  // Get User data
  Future<void> getUserData({
    required BuildContext context,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      navigatorPush() => Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }
      http.Response res = await http
          .get(Uri.parse("$url/user/getAllDetails"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!,
      });

      if (res.statusCode == 200) {
        user.setUser(res.body);
        print(jsonDecode(res.body));
        navigatorPush();
      } else {
        navigatorPop() => Navigator.pop(context);
        navigatorPush() => Navigator.pushNamed(context, SplashScreen.routeName);
        await prefs.clear();
        navigatorPop();
        navigatorPush();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get User all enquiries
  Future<void> getUserEnquiries({required BuildContext context}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http
          .get(Uri.parse("$url/user/getAllEnquiry"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!,
      });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Send Enquiry
  Future<bool> sendEnquiry({
    required BuildContext context,
    required String enquiryMsg,
    required String enquiryImage,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      var request =
          http.MultipartRequest("POST", Uri.parse("$url/user/sendEnquiry"));

      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!
      });

      if (enquiryImage != "") {
        request.files
            .add(await http.MultipartFile.fromPath("image", enquiryImage));
      }

      request.fields["enquiryMsg"] = enquiryMsg;
      request.fields["enquiryDate"] = DateTime.now().toString();

      var response = await request.send();
      var newResp = await http.Response.fromStream(response);
      httpErrorHandel(
          context: context,
          res: newResp,
          onSuccess: () {
            user.setUser(newResp.body);
          });
      if (newResp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  // Get Stock list according to locations
  Future<List<dynamic>> getStockList(
      {required BuildContext context, required String stateName}) async {
    try {
      List<dynamic> stockList = [];
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }
      http.Response res = await http.get(
          Uri.parse("$url/user/stockList?loc=$stateName"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            stockList.addAll(jsonDecode(res.body));

            // print(jsonDecode(res.body));
            // stock.setStock(res.body);
          });
      print("stock List");
      print(stockList);
      return stockList;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // Get Stock list for Retails
  Future<List<dynamic>> getRetailStockList(
      {required BuildContext context}) async {
    try {
      List<dynamic> stockList = [];
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }
      http.Response res = await http.get(Uri.parse("$url/user/retailStockRate"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            stockList.addAll(jsonDecode(res.body));

            // print(jsonDecode(res.body));
            // stock.setStock(res.body);
          });
      print("stock List");
      print(stockList);
      return stockList;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // Send Order
  Future<void> sendOrder({
    required BuildContext context,
    required String date,
    required String time,
    required String fullName,
    required String number,
    required String state,
    required double netPrice,
    required int orderQuantity,
    required double orderAmount,
    required String stockId,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/user/sendOrder"),
          body: jsonEncode({
            "date": date,
            "time": time,
            "fullName": fullName,
            "number": number,
            "state": state,
            "netPrice": netPrice,
            "orderQuantity": orderQuantity,
            "orderAmount": orderAmount,
            "stockId": stockId,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get All Orders
  Future<List<dynamic>> getAllOrders({required BuildContext context}) async {
    try {
      List<dynamic> oldOrderList = [];
      List<dynamic> newOrderList = [];
      showsnakcBar() => showSnackBar(context, "Error");
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(Uri.parse("$url/user/getAllOrders"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      if (res.statusCode == 200) {
        // user.setUser(res.body);
        for (var i = 0; i < jsonDecode(res.body)["newOrder"].length; i++) {
          var order = jsonDecode(res.body)["newOrder"][i];
          newOrderList.add(order);
        }
        for (var i = 0; i < jsonDecode(res.body)["oldOrder"].length; i++) {
          var order = jsonDecode(res.body)["oldOrder"][i];
          oldOrderList.add(order);
        }
        return [newOrderList, oldOrderList];
      } else {
        showsnakcBar();
        return [];
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // Get My Bills
  Future<List<List<dynamic>>> getAllBills({
    required BuildContext context,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");

      List<dynamic>? billList = [];
      List<dynamic>? pdfBill = [];

      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(Uri.parse("$url/user/getAllBills"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      http.Response pdfBills = await http.get(
          Uri.parse("$url/user/get/uploadedBills"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token
          });

      print(jsonDecode(res.body)["billPdf"]);
      if (res.statusCode == 200 && pdfBills.statusCode == 200) {
        // user.setUser(res.body);
        for (var i = 0; i < jsonDecode(res.body)["bills"].length; i++) {
          var billData = jsonDecode(res.body)["bills"][i];
          billList.add(billData);
        }
        for (var i = 0; i < jsonDecode(pdfBills.body)["billPdf"].length; i++) {
          var pdf = jsonDecode(pdfBills.body)["billPdf"][i];
          pdfBill.add(pdf);
        }
        print("pdf");
        print(pdfBill);
        return [billList, pdfBill];
      } else {
        return [];
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // My transaction api
  Future<List<dynamic>> getAllTransactions(
      {required BuildContext context}) async {
    try {
      List<dynamic> transactionList = [];
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/user/getAllTransactions"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      if (res.statusCode == 200) {
        // user.setUser(res.body);
        for (var i = 0; i < jsonDecode(res.body)["transactions"].length; i++) {
          var transactionData = jsonDecode(res.body)["transactions"][i];
          transactionList.add(transactionData);
        }
        return transactionList;
      } else {
        return [];
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // Get Receipts api
  Future<List<dynamic>> getAllReceipts({required BuildContext context}) async {
    try {
      List<dynamic> receiptList = [];
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");

      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(Uri.parse("$url/user/getAllReceipts"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      if (res.statusCode == 200) {
        // user.setUser(res.body);
        for (var i = 0; i < jsonDecode(res.body)["receipts"].length; i++) {
          var receiptData = jsonDecode(res.body)["receipts"][i];
          receiptList.add(receiptData);
        }
        return receiptList;
      } else {
        return [];
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // My balance api
  Future<void> getBalance({required BuildContext context}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");

      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(Uri.parse("$url/user/getAllDetails"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Profile
  Future<void> updateProfile({
    required BuildContext context,
    required String fullName,
    required String number,
    required String email,
    required String address,
    required String businessType,
    required String zipCode,
    required String city,
    required String state,
    required String profilePic,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      var request =
          http.MultipartRequest("POST", Uri.parse("$url/user/updateProfile"));

      request.headers.addAll({
        "Content-Type": "application/json; charse=UTF-8",
        "x-auth-token": token!
      });

      request.files
          .add(await http.MultipartFile.fromPath("profilePic", profilePic));

      request.fields['fullName'] = fullName;
      request.fields['number'] = "+91$number";
      request.fields['email'] = email;
      request.fields['address'] = address;
      request.fields['businessType'] = businessType;
      request.fields['zipCode'] = zipCode;
      request.fields['city'] = city;
      request.fields['state'] = state;

      var response = await request.send();

      var newResp = await http.Response.fromStream(response);
      httpErrorHandel(
          context: context,
          res: newResp,
          onSuccess: () {
            user.setUser(newResp.body);
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get all Stocks
  Future<List<dynamic>> getAllStock({required BuildContext context}) async {
    try {
      List<dynamic> newlist = [];
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");

      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/user/get/stockStatement"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      if (res.statusCode == 200) {
        print("length => ${jsonDecode(res.body)["allStockStatements"].length}");
        print("stock statement => ${jsonDecode(res.body)}");
        for (var i = 0;
            i < jsonDecode(res.body)["allStockStatements"].length;
            i++) {
          var element = jsonDecode(res.body)["allStockStatements"][i];
          newlist.add(element);
        }
        return newlist;
      } else {
        return newlist;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  // Subscribe user api
  Future<void> subscribeUser({
    required BuildContext context,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(Uri.parse("$url/user/subscribe"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get State-Stock Map api
  Future<List<String>> stateStockMap({
    required BuildContext context,
  }) async {
    try {
      List<String> stateList = [];
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");

      if (token == null || token.isEmpty) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(Uri.parse("$url/user/stateStockMap"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            var ss = jsonDecode(res.body);
            for (var i = 0; i < ss.length; i++) {
              stateList.add(ss[i]);
            }
          });

      return stateList;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }
}
