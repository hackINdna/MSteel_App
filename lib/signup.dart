import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_steel/main.dart';
import 'package:m_steel/otp_verification.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/gradient_container.dart';
import 'package:m_steel/widgets/password_textformfield.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const routeName = "/signup";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  String? _zipCodeErrorText;
  bool _businessTypeError = false; //changes when register is pressed

  String? _fullName,
      _phoneNumber,
      _email,
      _password,
      _confirmPassword,
      _language,
      _zipCode,
      _city,
      _state,
      _businessType;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != true || _businessType == null) {
      setState(() {
        if (_businessType == null) {
          _businessTypeError = true;
        } else {
          _businessTypeError = false;
        }
      });
      return;
    }
    if (_zipCodeErrorText != null) return;
    _formKey.currentState?.save();
    //setting language
    var langIndex = languageList.indexOf(_language ?? "English");
    saveLocale(langIndex);
    TheApplication.setLocale(context, languageLocales[langIndex]);
    currentLocaleIndex = langIndex;

    print(
        "name=$_fullName\nphone=$_phoneNumber\nemail=$_email\npass=$_password\nconf_pass=$_confirmPassword\nlang=$_language\nzip=$_zipCode\ncity=$_city\nstate=$_state\nbusiinessType=$_businessType");
    Navigator.pushNamed(context, OtpVerificationScreen.routeName);
  }

  void languageSelected(String lang) {
    setState(() {
      _language = lang;
    });
  }

  void businessSelected(String business) {
    setState(() {
      _businessTypeError = false;
      _businessType = business;
    });
  }

  Future<void> zipEntered(String zip) async {
    navigatePop() => Navigator.pop(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
    try {
      http.Response resp = await http
          .get(Uri.parse("https://api.postalpincode.in/pincode/$zip"));
      var postOffices = jsonDecode(resp.body)[0]["PostOffice"];
      navigatePop();

      if (postOffices == null) {
        setState(() {
          _zipCodeErrorText = "No Data found for entered ZIP code.";
          // _loading = false;
        });
        return;
      }
      setState(() {
        // _loading = false;
        _zipCodeErrorText = null;
        _cityController.text = postOffices.first["District"];
        _stateController.text = postOffices.first["State"];
      });
    } on Exception catch (e) {
      // _loading = false;
      navigatePop();
      showSnackBar(context,
          "Error loading ZIP data.\nMake sure you are connected to internet");
      setState(() {
        _zipCodeErrorText = "Unable to verify ZIP";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBgContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment(0, 0.45),
                  heightFactor: 3.3,
                  child: Text(
                    "Sign up",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.7,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: offWhiteBG,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //fullname
                        const SizedBox(height: 25),
                        Text(
                          "Full Name",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: formTextFieldInputDecoration(
                            hintText: "Enter your full name",
                          ),
                          onSaved: (newValue) {
                            _fullName = newValue;
                          },
                          validator: (value) {
                            if ((value != null && value.length > 2)) {
                              return null;
                            } else {
                              return "Valid name is required.";
                            }
                          },
                        ),
                        //mobile number
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
                            hintText: "Enter Mobile Number",
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
                        const SizedBox(height: 20),
                        //email
                        Text(
                          "Email Id",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: formTextFieldInputDecoration(
                            hintText: "Enter email Id",
                          ),
                          onSaved: (newValue) {
                            _email = newValue;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return null;
                            } else if ((value != null && value.isNotEmpty) &&
                                RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                                    .hasMatch(value)) {
                              return null;
                            } else {
                              return "Invalid Email Address.";
                            }
                          },
                        ),
                        //password
                        const SizedBox(height: 15),
                        Text(
                          "Password",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        PasswordTextFormField(
                          hintText: "Enter Password",
                          onSaved: (String? pass) {
                            _password = pass;
                          },
                          onChanged: (pass) {
                            _password = pass;
                          },
                        ),
                        //confirm password
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Confirm Password",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        PasswordTextFormField(
                          hintText: "Re-Enter Password",
                          onSaved: (String? pass) {
                            _confirmPassword = pass;
                          },
                          validator: (confPass) {
                            if (confPass != null &&
                                confPass.length > 5 &&
                                confPass == _password) {
                              return null;
                            } else if (confPass != null &&
                                confPass.length > 5 &&
                                confPass != _password) {
                              return "Password does not match.";
                            } else {
                              return "Minimum password length is 6";
                            }
                          },
                        ),
                        //language dropdown
                        const SizedBox(height: 25),
                        Text(
                          "Choose Language",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text("Language"),
                              value: _language,
                              items: languageList
                                  .map((language) => DropdownMenuItem(
                                        value: language,
                                        child: Text(language),
                                      ))
                                  .toList(),
                              onChanged: (lang) => languageSelected(lang!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        //business type dropdown
                        const SizedBox(height: 25),
                        Text(
                          "Business Type",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: (_businessTypeError)
                                ? Border.all(width: 2, color: Colors.red)
                                : null,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text("Business"),
                              value: _businessType,
                              items: businessTypeList
                                  .map((business) => DropdownMenuItem(
                                        value: business,
                                        child: Text(business),
                                      ))
                                  .toList(),
                              onChanged: (business) =>
                                  businessSelected(business!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        (_businessTypeError)
                            ? const Text(
                                "\t\t\t\tPlease select a Business type.",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w400))
                            : const SizedBox(height: 0),
                        //zip
                        const SizedBox(height: 20),
                        Text(
                          "Zip Code",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: formTextFieldInputDecoration(
                            hintText: "Enter Zip Code",
                            errorText: _zipCodeErrorText,
                          ),
                          onSaved: (newValue) {
                            _zipCode = newValue;
                          },
                          onChanged: (value) async {
                            if (value.length == 6) {
                              zipEntered(value);
                            } else {
                              setState(() {
                                _cityController.text = "";
                                _stateController.text = "";
                              });
                            }
                          },
                          validator: (value) {
                            if ((value != null && value.isNotEmpty) &&
                                value.length == 6) {
                              return null;
                            } else {
                              return "Invalid Zip Code.";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        //city
                        Text(
                          "City",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          controller: _cityController,
                          decoration: formTextFieldInputDecoration(
                            hintText: "Enter Zip for City",
                          ),
                          onSaved: (newValue) {
                            _city = _cityController.text;
                          },
                        ),
                        //state
                        const SizedBox(height: 25),
                        Text(
                          "State",
                          style: formFieldHeadingTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          controller: _stateController,
                          decoration: formTextFieldInputDecoration(
                            hintText: "Enter Zip for State",
                          ),
                          onSaved: (newValue) {
                            _state = _stateController.text;
                          },
                        ),
                        const SizedBox(height: 35),
                        //register button
                        ElevatedButton(
                          onPressed: () => _submit(),
                          style: fullBlueButtonStyle(),
                          child: const Text("Register"),
                        ),
                        const Align(
                          heightFactor: 2,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Contact us on $contactNumber",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
    _stateController.dispose();
  }
}
