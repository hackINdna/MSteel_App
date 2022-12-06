import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_steel/my_orders.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bottom_sheet_icon_button.dart';
import 'package:m_steel/widgets/drawer_list_tile.dart';
import 'package:m_steel/widgets/language_changer_container.dart';

//colors
const headingColor = Color(0xff005C77);
const offWhiteBG = Color(0xffEFEFEF);
const appBlueBg = Color(0xff0F9EE8);
const boxBorderColor = Color(0xffCDCDCD);
const Map<String, Color> statusColors = {
  "completed": Color(0xff009A19),
  "incompleted": Color(0xffE11212),
  "pending": Color(0xffD9C749),
  "approved": Color(0xff009A19),
  "shippingInProcess": Color(0xff53BAF7),
  "grayText": Color(0xFF7E7E7E),
  "sectionDivider": Color(0xffCDCDCD),
};
const themeColors = <Color>[
  Color(0xff76C0B6),
  Color(0xff34A2B4),
  Color(0xff1894B8),
];

//info
const contactNumber = "+91 0000 00 0000";
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
    counterText: "",
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
TextButton alertOkTextButton(BuildContext context, {String? text}) {
  text ??= transText(context).ok;
  return TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text(text),
  );
}

//alert box rounded corner shape
RoundedRectangleBorder alertBoxShape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
}

Center bottomSheetTopBar() {
  return Center(
    child: Container(
      height: 3.5,
      width: 47,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(3.5)),
    ),
  );
}

//image picker botomsheet dialog
Future<void> openModalBottomSheet(
  BuildContext context,
  Function() onDeletePressed,
  void Function(ImageSource) imageSelect,
) =>
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) => Container(
              padding: const EdgeInsets.all(12),
              //height: MediaQuery.of(context).size.height * 0.21,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 2),
                  bottomSheetTopBar(),
                  const SizedBox(height: 3.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: Text(
                          transText(context).uploadPhoto,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => onDeletePressed.call(),
                        icon: Icon(Icons.delete, color: themeColors.last),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      BottomSheetIconButton(
                        icon: Icons.camera_alt,
                        onTap: () => imageSelect(ImageSource.camera),
                      ),
                      const SizedBox(width: 10),
                      BottomSheetIconButton(
                        onTap: () => imageSelect(ImageSource.gallery),
                        icon: Icons.photo_library,
                      ),
                    ],
                  )
                ],
              ),
            ));

//image picker
Future<XFile?> pickImage(ImageSource source) async {
  try {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image == null) {
      //for retreiving image, lost when phone closes app due to memory issues
      final response = await picker.retrieveLostData();
      return response.file;
      //return null;
    }
    return image;
  } on PlatformException catch (e) {
    print("image pick exception: $e");
    return null;
  }
}
