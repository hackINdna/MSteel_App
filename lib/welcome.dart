import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m_steel/home.dart';
import 'package:m_steel/util/general.dart';
// import 'package:m_steel/widgets/gradient_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const routeName = "/welcome";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _nextEnabled = false;
  late SharedPreferences prefs;
  void _userAgreementClicked() {
    print("user agreemnt");
  }

  void _termsofServiceClicked() {
    print("terms of serv. clicked");
  }

  void _privacyPolicyClicked() {
    print("Prv Pol clicked");
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: appBlueBg,
        body: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            clipBehavior: Clip.antiAlias,
            children: [
              SizedBox(
                  // height: screenSize.height * 0.25,
                  width: screenSize.width * 0.52,
                  child: Image.asset(
                    "assets/images/hi_img.png",
                    fit: BoxFit.contain,
                  )),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "WELCOME",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Ipsum ac quam diam feugiat tellus eget facilisi quam lectus. Eu nunc sed non amet. Lacus rhoncus id lectus nec. Interdum nunc libero leo sagittis in eu euismod.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(screenSize.width * 0.12),
                      child: Image.asset(
                        "assets/images/welcome_img.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 15, top: 11, bottom: 11),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.white,
                            checkColor: appBlueBg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.4)),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    color: Colors.white, width: 2)),
                            value: _nextEnabled,
                            onChanged: (value) {
                              //disable next button on uncheck
                              setState(() {
                                if (value == true) {
                                  print("enabling button");
                                  _nextEnabled = true;
                                } else {
                                  print("disbling button");
                                  _nextEnabled = false;
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 12.3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text:
                                            "By proceeding to pay, I understand and agree with the "),
                                    TextSpan(
                                      text: "User Agreement",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      //TODO: what is .. below
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => _userAgreementClicked(),
                                    ),
                                    const TextSpan(text: ", "),
                                    TextSpan(
                                        text: "Terms of Services",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () => _termsofServiceClicked()),
                                    const TextSpan(text: " and "),
                                    TextSpan(
                                        text: "Privacy Policy",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () => _privacyPolicyClicked()),
                                    const TextSpan(text: " of MSteel.")
                                  ]),
                            ),
                            // Text(
                            //   "By proceeding to pay, i understand and agree with the User Agreement, Terms of Services and Privacy Policy of Msteel.",
                            //   style: TextStyle(fontSize: 12.3),
                            // ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(21, 6, 21, 0),
                      child: ElevatedButton(
                        onPressed: _nextEnabled
                            ? () {
                                prefs.setBool(LOGGED_IN, true).then((value) =>
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        HomeScreen.routeName,
                                        (route) => false));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[400],
                          minimumSize: const Size.fromHeight(43),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color:
                                  _nextEnabled ? appBlueBg2 : Colors.black26),
                        ),
                      ),
                    ),
                    const SizedBox(height: 37.2),
                    const Text(
                      "Copyright \u00A9 Technlogi.com ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              //const Divider(),
            ],
          ),
        ));
  }
}
