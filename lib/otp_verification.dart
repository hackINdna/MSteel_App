import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:m_steel/reset_password.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/welcome.dart';
import 'package:m_steel/widgets/gradient_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});
  static const routeName = "/otpVerification";

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? _code;
  bool _resending = false;
  final int _codeLength = 4;
  final int _timerSeconds = 15;
  late int _remainingSeconds;
  bool _enableResend = false;
  late Timer _timer;
  int? infoFromForgotPassword;

  String displayedSeconds() {
    return ((_remainingSeconds + 1).toString().length == 1)
        ? "00:0${_remainingSeconds + 1}"
        : "00:${_remainingSeconds + 1}";
  }

  void _resendOtp() {
    //otp resending
    if (_enableResend) {
      //resend otp
      _timer = _getTimer();
      if (_resending) {
        showSnackBar(context, "OTP sent again.");
      }
      _resending = true;
    }
  }

  void _otpVerification(String otp) {
    if (otp != "0000") {
      if (infoFromForgotPassword != null) {
        Navigator.pushNamed(context, ResetPasswordScreen.routeName);
      } else {
        Navigator.pushNamed(context, WelcomeScreen.routeName);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid OTP"),
          content: const Text("Invalid OTP Entered.\nCannot continue."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            )
          ],
        ),
      );
    }
  }

  Timer _getTimer() {
    _remainingSeconds = _timerSeconds;
    _enableResend = false;
    return Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds >= 1) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          timer.cancel();
          _enableResend = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = _timerSeconds;
    _timer = _getTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    infoFromForgotPassword = ModalRoute.of(context)?.settings.arguments as int?;
    var screenWidth = MediaQuery.of(context).size.width;
    return GradientBgContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(22.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //heading
                const Text(
                  "Enter OTP to verify Phone Number.",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                //otp fields
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    width: screenWidth * 0.75,
                    child: PinCodeTextField(
                      appContext: context,
                      length: _codeLength,
                      hapticFeedbackTypes: HapticFeedbackTypes.medium,
                      animationType: AnimationType.scale,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      pinTheme: PinTheme(
                        errorBorderColor: Colors.red,
                        shape: PinCodeFieldShape.circle,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      enableActiveFill: true,
                      onCompleted: (value) => _otpVerification(value),
                      onChanged: (value) {
                        //no realtine updating of values needed
                      },
                      beforeTextPaste: (text) {
                        if (text != null && int.tryParse(text) != null) {
                          print("ok to go pste");
                          return true;
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("OTP in wrong format"),
                              content: const Text(
                                  "OTP must only contain numeric digits."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok"))
                              ],
                            ),
                          );
                          return false;
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () => _enableResend ? _resendOtp() : null,
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.black12,
                      ),
                    ),
                    child: Text(
                      _enableResend
                          ? "Resend OTP"
                          : "Resend OTP in: ${displayedSeconds()}",
                      style: const TextStyle(
                          // decoration:
                          //     _enableResend ? TextDecoration.underline : null,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
