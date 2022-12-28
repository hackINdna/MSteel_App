import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bottom_sheet_icon_button.dart';

//pref keys
const BIOMETRIC_SUPPORT = "biometricSupport";
const LOGGED_IN = "loggedIn";
//colors
const headingColor = Color(0xff005C77);
const offWhiteBG = Color(0xffEFEFEF);
const appBlueBg = Color(0xff0F9EE8);
const appBlueBg2 = Color(0xff1894B8);
const boxBorderColor = Color(0xffCDCDCD);
const subscriptionGray = Color(0xff767676);
DateFormat dateDisplayFormat = DateFormat("dd MMM yyyy");
String dateToFormattedString(DateTime dt) {
  return dateDisplayFormat.format(dt);
}

String stringDateToFormattedString(String date) {
  DateTime dt = DateTime.parse(date);
  return dateToFormattedString(dt);
}

DateTime stringToDate(String date) => DateTime.parse(date);

class BoxColors {
  BoxColors._();
  static const completed = Color(0xff009A19);
  static const incompleted = Color(0xffE11212);
  static const pending = Color(0xffD9C749);
  static const approved = Color(0xff009A19);
  static const shippingInProcess = Color(0xff53BAF7);
  static const grayText = Color(0xFF7E7E7E);
  static const border = Color(0xffCDCDCD);
}

class StatusContent {
  final String text;
  final Text textWidget;
  final Color color;
  StatusContent(
      {required this.textWidget, required this.color, required this.text});
}

class OrderStatus {
  final BuildContext context;
  late StatusContent completed,
      incompleted,
      pending,
      approved,
      shippingInProcess,
      declined;
  OrderStatus.of(this.context) {
    completed = StatusContent(
      text: "completed",
      textWidget:
          _text(transText(context).completed, _style(BoxColors.completed)),
      color: BoxColors.completed,
    );
    incompleted = StatusContent(
      text: "incompleted",
      textWidget:
          _text(transText(context).incompleted, _style(BoxColors.incompleted)),
      color: BoxColors.incompleted,
    );
    pending = StatusContent(
      text: "pending",
      textWidget: _text(
        transText(context).pending,
        _style(BoxColors.pending),
      ),
      color: BoxColors.pending,
    );
    approved = StatusContent(
      text: "approved",
      textWidget: _text(
        transText(context).approved,
        _style(BoxColors.approved),
      ),
      color: BoxColors.approved,
    );
    shippingInProcess = StatusContent(
      text: "shippingInProcess",
      textWidget: _text(
        transText(context).shippingInProcess,
        _style(BoxColors.shippingInProcess),
      ),
      color: BoxColors.shippingInProcess,
    );
    declined = StatusContent(
      text: "declined",
      textWidget: _text(
        transText(context).declined,
        _style(BoxColors.incompleted),
      ),
      color: BoxColors.incompleted,
    );
  }
  TextStyle _style(Color color) => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: color,
      );
  Text _text(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.right,
    );
  }
}

StatusContent getStatusFromString(String str, BuildContext context) {
  switch (str) {
    case "completed":
      return OrderStatus.of(context).completed;
    case "pending":
      return OrderStatus.of(context).pending;
    case "approved":
      return OrderStatus.of(context).approved;
    case "shippingInProcess":
      return OrderStatus.of(context).shippingInProcess;
    case "declined":
      return OrderStatus.of(context).declined;
    case "incompleted":
    default:
      return OrderStatus.of(context).incompleted;
  }
}

var s = Colors;
const themeColors = <Color>[
  Color(0xff76C0B6),
  Color(0xff34A2B4),
  Color(0xff1894B8),
];

//info
const contactNumber = "+91 0000 00 0000";

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
InputDecoration formTextFieldInputDecoration(
    {String? hintText, String? errorText}) {
  return InputDecoration(
    errorText: errorText,
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
TextButton alertOkTextButton(BuildContext context,
    {String? text, Color? foregroundColor, TextStyle? textStyle}) {
  text ??= transText(context).ok;
  return TextButton(
    onPressed: () => Navigator.pop(context),
    style: TextButton.styleFrom(
      foregroundColor: foregroundColor,
      textStyle: textStyle,
    ),
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

//divider heading
Row dividerHeading(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 9),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const Expanded(
        child: Divider(
          thickness: 1,
          height: 0,
        ),
      )
    ],
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

//capitalize first letter function
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
