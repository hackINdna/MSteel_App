import 'package:flutter/material.dart';
import 'package:m_steel/my_orders.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/drawer_list_tile.dart';
import 'package:m_steel/widgets/language_changer_container.dart';

//colors
const headingColor = Color(0xff005C77);
const offWhiteBG = Color(0xffEFEFEF);
const appBlueBg = Color(0xff0F9EE8);
const themeColors = <Color>[
  Color(0xff76C0B6),
  Color(0xff34A2B4),
  Color(0xff1894B8),
];

//info
const contactNumber = "+91 3333 33 3333";
const List<String> languageList = [
  "English",
  "Hindi",
  "Tamil",
  "Telugu",
  "Kannada",
  "Malayalam",
  "Marathi",
  "Gujarati",
  // "Odiya",
  "Bengali",
  "Punjabi",
  "Assamese"
];
const List<Locale> languageLocales = [
  Locale(ENGLISH, INDIA),
  Locale(HINDI, INDIA),
  Locale(TAMIL, INDIA),
  Locale(TELUGU, INDIA),
  Locale(KANNADA, INDIA),
  Locale(MALAYALAM, INDIA),
  Locale(MARATHI, INDIA),
  Locale(GUJRATI, INDIA),
  Locale(BENGALI, INDIA),
  Locale(PUNJABI, INDIA),
  Locale(ASSAMESE, INDIA),
];
const List<String> businessTypeList = ["Retail / Factory", "B2B / B2C"];
//form field heading TextStyle
TextStyle formFieldHeadingTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.5,
  );
}

//appbar title text
Text appBarTitle() {
  return const Text(
    "MSteel",
    style: TextStyle(fontWeight: FontWeight.w500),
  );
}

//Gradient Box Decoration
BoxDecoration gradientBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: themeColors,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0, 0.45, 1.0],
    ),
  );
}

//form TextField decoration
InputDecoration formTextFieldInputDecoration({String? hintText}) {
  return InputDecoration(
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
    hintText: (hintText != null) ? hintText : "",
    hintStyle: const TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
  );
}

//full blue button style
ButtonStyle fullBlueButtonStyle() {
  return ButtonStyle(
    side: MaterialStateProperty.all(
      BorderSide(
        color: themeColors.last,
        width: 0,
      ),
    ),
    minimumSize: MaterialStateProperty.all(const Size(double.maxFinite, 47)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    )),
    textStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 14),
    ),
  );
}

//general appbar
AppBar generalAppbar() {
  return AppBar(
    backgroundColor: appBlueBg,
    elevation: 3,
    title: appBarTitle(),
    centerTitle: true,
  );
}

//heading Text
Text headingText(String heading) {
  return Text(heading,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15.2,
      ));
}

//alert ok button
TextButton alertOkTextButton(BuildContext context) {
  return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(transText(context).ok));
}
