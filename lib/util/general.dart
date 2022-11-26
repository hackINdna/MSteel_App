import 'package:flutter/material.dart';

//colors
const headingColor = Color(0xff005C77);
const offWhiteBG = Color(0xffEFEFEF);
const themeColors = <Color>[
  Color(0xff76C0B6),
  Color(0xff34A2B4),
  Color(0xff1894B8)
];

//info
const contactNumber = "+91 3333 33 3333";
//form field heading TextStyle
TextStyle formFieldHeadingTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.5,
  );
}

//Gradient Box Decoration
BoxDecoration gradientBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: themeColors,
      //tileMode: TileMode.clamp,
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
