import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:m_steel/home.dart';
import 'package:m_steel/login.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/gradient_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});
  static const routeName = "/biometricAuthentication";

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  late SharedPreferences preferences;
  bool? _biometricSupport;
  bool _loggedIn = false;
  LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;
  String _message = "Proceed with Authentication.";
  bool _showSkip = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(BIOMETRIC_SUPPORT) == null) {
      _biometricSupport = await _isBiometricSupported();
      preferences.setBool(BIOMETRIC_SUPPORT, _biometricSupport!);
    } else {
      _biometricSupport = preferences.getBool(BIOMETRIC_SUPPORT);
    }
    if (preferences.getBool(LOGGED_IN) == null) {
      _loggedIn = await preferences.setBool(LOGGED_IN, false);
    } else {
      _loggedIn = preferences.getBool(LOGGED_IN) ?? false;
    }
    _availableBiometrics = await _getAvailableBiometrics();
    setState(() {});
    if (_biometricSupport != true) {
      return;
    }
    try {
      await auth.authenticate(
          localizedReason: "Biometric Authentication for login",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
                //cancelButton: "Skip",
                )
          ]).then((value) {
        if (value) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Authentication failed"),
                    content: const Text(
                        "Device level authentication failed.\nLog in using credentials."),
                    actions: [alertOkTextButton(context)],
                  ));
        }
      });
    } on PlatformException catch (e) {
      switch (e.code) {
        case auth_error.biometricOnlyNotSupported:
          {
            print("biom only not supported");
            break;
          }
        case auth_error.lockedOut:
          {
            print("locked out");
            break;
          }
        case auth_error.notAvailable:
          {
            _showSkip = true;
            //no support of hardware
            if (_biometricSupport == false) {
              setState(() {
                _message =
                    "No Security is set on your device.\nPrefer setting a PIN or PATTERN LOCK for extra security.";
              });
            } else if (_biometricSupport == true) {
              setState(() {
                _message =
                    "No Biometric Security is set on your device.\nPrefer setting some type of security.";
              });
            }
            break;
          }
        case auth_error.passcodeNotSet:
          {
            print("Passcode not set");
            break;
          }
        case auth_error.notEnrolled:
          {
            print("fingerprint not set");
            break;
          }
        case auth_error.permanentlyLockedOut:
          {
            print("perma locked out");
            break;
          }
        case auth_error.otherOperatingSystem:
          {
            print("other OS");
            break;
          }
      }
    }
  }

  Future<bool> _isBiometricSupported() async {
    try {
      return await auth.canCheckBiometrics || await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print("error while chekcking biometricSupport = $e");
      return false;
    }
  }

  Future<List<BiometricType>> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print("Error checking availableBiometrics = $e");
    }
    return availableBiometrics;
  }

  void clearPrefAndLogInNav() async {
    await preferences.setBool(LOGGED_IN, false).then((value) =>
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return GradientBgContainer(
        child: SafeArea(
            child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(22.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 42,
                bottom: 12,
              ),
              child: Text(
                "Biometric Sign in.",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              _message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: const Alignment(0.92, 0),
              child: OutlinedButton.icon(
                onPressed: () {
                  clearPrefAndLogInNav();
                  // if (_showSkip) {
                  //   clearPrefAndLogInNav();
                  // } else {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //       HomeScreen.routeName, (route) => false);
                  // }
                },
                icon: const Icon(Icons.arrow_forward_ios_sharp, size: 17),
                label: Text(_showSkip ? "Skip" : "Login with credentials"),
                style: OutlinedButton.styleFrom(
                    backgroundColor: appBlueBg,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
