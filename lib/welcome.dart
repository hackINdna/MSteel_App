import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m_steel/home.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/gradient_container.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //welcome box
          Container(
            decoration: const BoxDecoration(
              color: appBlueBg,
              //due to gradient removal
              // gradient: LinearGradient(
              //   colors: themeColors,
              //   //tileMode: TileMode.clamp,
              //   begin: Alignment.topRight,
              //   end: Alignment.bottomLeft,
              //   stops: [0, 0.45, 1.0],
              // ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 44,
                  horizontal: screenSize.width * 0.17,
                ),
                child: Image.asset(
                  "assets/images/welcome_img.png",
                ),
              ),
            ),
          ),
          //central hi area
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.51,
                    child: Image.asset("assets/images/hi_img.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Ipsum ac quam diam feugiat tellus eget facilisi quam lectus. Eu nunc sed non amet. Lacus rhoncus id lectus nec. Interdum nunc libero leo sagittis in eu euismod.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //const Divider(),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 15, top: 11, bottom: 11),
            child: Row(
              children: [
                Checkbox(
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
                          color: Color(0xff5B5B5B),
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          const TextSpan(
                              text:
                                  "By proceeding to pay, I understand and agree with the "),
                          TextSpan(
                            text: "User Agreement, ",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                            //TODO: what is .. below
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _userAgreementClicked(),
                          ),
                          TextSpan(
                              text: "Terms of Services ",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _termsofServiceClicked()),
                          const TextSpan(text: "and "),
                          TextSpan(
                              text: "Privacy Policy ",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _privacyPolicyClicked()),
                          const TextSpan(text: "of MSteel.")
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
          Align(
            alignment: const Alignment(0.84, 0),
            child: ElevatedButton(
              onPressed: _nextEnabled
                  ? () {
                      prefs.setBool(LOGGED_IN, true).then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false));
                    }
                  : null,
              style:
                  ElevatedButton.styleFrom(backgroundColor: themeColors.last),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Copyright \u00A9 Technlogi.com ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
