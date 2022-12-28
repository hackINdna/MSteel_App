import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_steel/otp_verification.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/gradient_container.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = "/otpLogin";
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? _phoneNumber;
  final _phoneController = TextEditingController();
  bool _valid = false;
  String? _error;
  void _validate() {
    var value = _phoneController.text;
    if (value.isEmpty) {
      _error = "Phone number required.";
    } else if (value.isNotEmpty &&
        RegExp(r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
            .hasMatch(value)) {
      _valid = true;
      _error = null;
    } else {
      _valid = false;
      _error = "Invalid Mobile Number.";
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool fromForgotPassword =
        (ModalRoute.of(context)?.settings.arguments ?? false) as bool;
    return GradientBgContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(22.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 42,
                      bottom: 12,
                    ),
                    child: Text(
                      (fromForgotPassword)
                          ? "Forgot Password"
                          : "Phone Number Verification",
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    (fromForgotPassword)
                        ? "Enter your mobile number to reset your password."
                        : "Enter your Phone Number to receive an OTP to Sign into your Account.",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Mobile Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autofocus: true,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 2,
                          color: themeColors.last,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.redAccent,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 2,
                          color: themeColors.last,
                        ),
                      ),
                      fillColor: Colors.white,
                      hintText: "Enter Mobile Number.",
                      errorText: _error,
                      errorStyle: const TextStyle(
                        color: Colors.white60,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _validate();
                      });
                      if (_valid) {
                        //send OtP
                        Navigator.pushNamed(
                            context, OtpVerificationScreen.routeName,
                            arguments: (fromForgotPassword) ? 1234 : null);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff005C77),
                      ),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.maxFinite, 47)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14),
                      ),
                    ),
                    child: const Text("Get OTP"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
