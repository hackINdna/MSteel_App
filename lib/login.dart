import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_steel/biometric_auth.dart';
import 'package:m_steel/forgot_password.dart';
import 'package:m_steel/home.dart';
import 'package:m_steel/signup.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/gradient_container.dart';
import 'package:m_steel/widgets/password_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  String? _phoneNumber;
  String? _password;
  bool _loggedIn = false;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initPrefs().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, BiometricAuthScreen.routeName);
      }
    });
  }

  Future<bool> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(LOGGED_IN) == null) {
      await prefs.setBool(LOGGED_IN, false);
    }
    _loggedIn = prefs.getBool(LOGGED_IN) ?? false;
    return _loggedIn;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) return;
    _formKey.currentState?.save();
    print("phone = $_phoneNumber\npass = $_password");
    prefs.setBool(LOGGED_IN, true).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GradientBgContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.3,
                child: const Align(
                  alignment: Alignment(0, 0.45),
                  child: Text(
                    "My Steel",
                    textAlign: TextAlign.center,
                    textScaleFactor: 2.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(minHeight: height * 0.7),
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: offWhiteBG,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        // alignment: Alignment(0, -2),
                        heightFactor: 2,
                        child: Text(
                          "Login",
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Mobile Number",
                        style: formFieldHeadingTextStyle(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: formTextFieldInputDecoration(
                          hintText: "Enter your Mobile Number",
                        ),
                        onSaved: (newValue) {
                          _phoneNumber = newValue;
                        },
                        validator: (value) {
                          if ((value != null && value.isNotEmpty) &&
                              RegExp(r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
                                  .hasMatch(value)) {
                            return null;
                          } else {
                            return "Invalid Phone number.";
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 15),
                      Text(
                        "Password",
                        style: formFieldHeadingTextStyle(),
                      ),
                      const SizedBox(height: 10),
                      PasswordTextFormField(
                        hintText: "Enter your Password",
                        onSaved: (String? s) {
                          _password = s;
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.85,
                        // child: InkWell(
                        //     onTap: () => _submit(),
                        //     child: const Text(
                        //       "Forgot Password?",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     )),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ForgotPasswordScreen.routeName,
                                arguments: true);
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _submit(),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(themeColors.last),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.maxFinite, 47),
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: const Text("Login"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(left: 51),
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Or",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 51),
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPasswordScreen.routeName);
                        },
                        style: fullBlueButtonStyle(),
                        child: Text(
                          "Login with OTP",
                          style: TextStyle(color: themeColors.last),
                        ),
                      ),
                      const Align(
                        heightFactor: 2.3,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Contact us on $contactNumber",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Align(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignupScreen.routeName);
                          },
                          child: const Text.rich(
                            style: TextStyle(color: Colors.black87),
                            TextSpan(
                              text: "Don't have an account? ",
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
