import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/authScreen/biometric_auth.dart';
import 'package:m_steel/authScreen/forgot_password.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/homePage/home.dart';
import 'package:m_steel/authScreen/signup.dart';
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
  // var _isLoading = false;
  // bool _loggedIn = false;

  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  String? _password;
  late SharedPreferences prefs;
  late FocusNode _focusNode;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    initPrefs().then((value) {
      if (value != "") {
        Navigator.pushReplacementNamed(context, BiometricAuthScreen.routeName);
      }
      _focusNode = FocusNode();
    });
  }

  Future<String> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("x-auth-token") == null ||
        prefs.getString("x-auth-token") == "") {
      await prefs.setString("x-auth-token", "");
    }
    // _loggedIn = prefs.getBool("x-auth-token") ?? false;
    return prefs.getString("x-auth-token")!;
  }

  Future<void> _submit() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) return;
    _formKey.currentState?.save();
    showCircularProgressIndicator(context: context);
    await authService.login(context: context, number: _phoneNumber!);
    // await authService.login(
    //     context: context, number: _phoneNumber!, password: _password!);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    print("phone = $_phoneNumber\npass = $_password");
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
                height: height * 0.27,
                child: Align(
                  alignment: const Alignment(0, 0.45),
                  child: Text(
                    "My Steel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: height * 0.73),
                padding: EdgeInsets.only(
                    top: height * 0.047,
                    left: height * 0.047,
                    right: height * 0.047),
                decoration: const BoxDecoration(
                  color: offWhiteBG,
                  // color: Colors.red,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        // alignment: Alignment(0, -2),
                        heightFactor: height * 0.0015,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        "Mobile Number",
                        style: TextStyle(
                            fontSize: height * 0.019,
                            fontWeight: FontWeight.w500),
                        // style: formFieldHeadingTextStyle(),
                      ),
                      SizedBox(height: height * 0.019),
                      SizedBox(
                        height: height * 0.06,
                        child: TextFormField(
                          maxLength: 10,
                          style: TextStyle(
                            fontSize: height * 0.02,
                          ),
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
                      ),
                      SizedBox(height: height * 0.04),
                      // Text(
                      //   "Password",
                      //   style: TextStyle(
                      //     fontSize: height * 0.019,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   // style: formFieldHeadingTextStyle(),
                      // ),
                      // SizedBox(height: height * 0.019),
                      // SizedBox(
                      //   height: height * 0.06,
                      //   child: PasswordTextFormField(
                      //     hintText: "Enter your Password",
                      //     onSaved: (String? s) {
                      //       _password = s;
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: height * 0.019),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   heightFactor: height * 0.0010,
                      //   // child: InkWell(
                      //   //     onTap: () => _submit(),
                      //   //     child: const Text(
                      //   //       "Forgot Password?",
                      //   //       style: TextStyle(
                      //   //         fontWeight: FontWeight.w500,
                      //   //       ),
                      //   //     )),
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(
                      //           context, ForgotPasswordScreen.routeName,
                      //           arguments: true);
                      //     },
                      //     child: Text(
                      //       "Forgot Password?",
                      //       style: TextStyle(
                      //           color: Colors.black87,
                      //           fontSize: height * 0.019),
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          _submit();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(themeColors.last),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              fontSize: height * 0.017,
                            ),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(
                            Size(double.maxFinite, height * 0.06),
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: const Text("Send OTP"),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //         child: Padding(
                      //       padding: EdgeInsets.only(left: width * 0.14),
                      //       child: const Divider(
                      //         color: Colors.black,
                      //         thickness: 1,
                      //       ),
                      //     )),
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(
                      //         "Or",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: height * 0.017,
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(right: width * 0.14),
                      //         child: const Divider(
                      //           color: Colors.black,
                      //           thickness: 1,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // OutlinedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(
                      //         context, ForgotPasswordScreen.routeName);
                      //   },
                      //   // style: fullBlueButtonStyle(),
                      //   style: ButtonStyle(
                      //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //     side: MaterialStateProperty.all(
                      //       BorderSide(
                      //         color: themeColors.last,
                      //         width: 0,
                      //       ),
                      //     ),
                      //     minimumSize: MaterialStateProperty.all(
                      //         Size(double.maxFinite, height * 0.06)),
                      //     shape:
                      //         MaterialStateProperty.all(RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //     )),
                      //     textStyle: MaterialStateProperty.all(
                      //       TextStyle(fontSize: height * 0.020),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     "Login with OTP",
                      //     style: TextStyle(color: themeColors.last),
                      //   ),
                      // ),
                      Align(
                        heightFactor: height * 0.0025,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Contact us on $contactNumber",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.020),
                        ),
                      ),
                      Align(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignupScreen.routeName);
                          },
                          child: Text.rich(
                            style: const TextStyle(color: Colors.black87),
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(fontSize: height * 0.020),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    fontSize: height * 0.020,
                                    decoration: TextDecoration.underline,
                                    color: appBlueBg,
                                    fontWeight: FontWeight.w600,
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
