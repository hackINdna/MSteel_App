import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/bottom_sheet_icon_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const routeName = "/updateProfile";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? image;
  bool _imageSelected = false;
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _zipCodeController = TextEditingController();
  String? _zipCodeErrorText,
      _nameErrorText,
      _emailErrorText,
      _addressErrorText,
      _phoneNumberErrorText;

  void _fillPreText() {
    _nameController.text = "Terrence Stracke";
    _phoneNumberController.text = "9323833053";
    _emailController.text = "terrancestracke12@gmail.com";
    _addressController.text = "67807 Cummerata Mills";
    _zipCodeController.text = "302017";
    _cityController.text = "Jaipur";
    _stateController.text = "Rajasthan";
  }

  void _getAndSetImage(ImageSource src) async {
    Navigator.pop(context);
    var image = await pickImage(src);
    if (image != null) {
      setState(() {
        _imageSelected = true;
        this.image = File(image.path);
      });
    }
  }

  void _deleteSelectedImage() {
    if (_imageSelected) {
      setState(() {
        _imageSelected = false;
        image!.delete();
      });
    }
    Navigator.pop(context);
  }

  Future<void> zipEntered(BuildContext context, String zip) async {
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
          "Error loading ZIP data.\nMake sure you are connected to internet.");
      setState(() {
        _zipCodeErrorText = "Unable to verify ZIP";
      });
    }
  }

  void _submit() async {
    print("submit->");
    if (!validate()) {
      print("vlaidation faied");
      return;
    }
    //submit form here
    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 260));
    showSnackBar(context, "Profile has been updated");
    print(
        "New values:name = ${_nameController.text}\n phone=${_phoneNumberController.text}\nemail=${_emailController.text}\naddress=${_addressController.text},${_cityController.text},${_stateController.text},zip=${_zipCodeController.text}");
  }

  bool validate() {
    var valid = true;
    //name
    if (_nameController.text.trim().length < 2) {
      valid = false;
      _nameErrorText = "Valid name is required";
    } else {
      _nameErrorText = null;
    }
    //email
    if (_emailController.text.trim().isNotEmpty) {
      if (!RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
          .hasMatch(_emailController.text)) {
        _emailErrorText = "Invalid Email";
        valid = false;
      } else {
        _emailErrorText = null;
      }
    }
    //phone
    if (_phoneNumberController.text.length != 10) {
      _phoneNumberErrorText = "Invalid phone number";
      valid = false;
    } else {
      _phoneNumberErrorText = null;
    }
    //address
    if (_addressController.text.isNotEmpty) {
      if (_addressController.text.length < 5) {
        _addressErrorText = "Address length inappropriate";
        valid = false;
      } else {
        _addressErrorText = null;
      }
    }
    //zip
    if (_zipCodeController.text.length != 6) {
      valid = false;
      _zipCodeErrorText = "Invalid ZIP";
      //verify ciondition
    } else {
      _zipCodeErrorText = null;
    }
    setState(() {});
    return valid;
  }

  @override
  void initState() {
    super.initState();
    _fillPreText();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return RootColumn(
      screenPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 21),
      heading: transText(context).profile,
      children: [
        Align(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: screenSize.width * 0.33,
                width: screenSize.width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.165),
                  color: Colors.white,
                ),
                child: _imageSelected
                    ? Image.file(
                        image!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/disp_dp.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                  bottom: screenSize.width * 0.026,
                  right: -screenSize.width * 0.021,
                  child: SizedBox(
                    height: 38,
                    width: 38,
                    child: BottomSheetIconButton(
                      bgColor: appBlueBg2,
                      icon: Icons.camera_alt,
                      size: 18.3,
                      onTap: () => openModalBottomSheet(
                        context,
                        _deleteSelectedImage,
                        _getAndSetImage,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        //name
        const SizedBox(height: 20),
        Text(
          "Full Name",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.name,
          decoration: formTextFieldInputDecoration(
            hintText: "Enter full name",
            errorText: _nameErrorText,
          ),
          controller: _nameController,
        ),
        //phone number
        const SizedBox(height: 20),
        Text(
          "Mobile Number",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: formTextFieldInputDecoration(
            hintText: "Enter mobile number",
            errorText: _phoneNumberErrorText,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 10,
          controller: _phoneNumberController,
        ),

        //email
        const SizedBox(height: 20),
        Text(
          "Email Id",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: formTextFieldInputDecoration(
            hintText: "Enter email Id",
            errorText: _emailErrorText,
          ),
          controller: _emailController,
        ),
        //address
        const SizedBox(height: 20),
        Text(
          "Address",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.streetAddress,
          decoration: formTextFieldInputDecoration(
            hintText: "Enter address",
            errorText: _addressErrorText,
          ),
          controller: _addressController,
        ),
        const SizedBox(height: 20),

        //zip code
        Text(
          "Zip Code",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLength: 6,
          onChanged: (value) async {
            if (value.length == 6) await zipEntered(context, value);
          },
          keyboardType: TextInputType.number,
          decoration: formTextFieldInputDecoration(
            hintText: "Enter zip code",
            errorText: _zipCodeErrorText,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: _zipCodeController,
        ),
        const SizedBox(height: 20),

        //city
        Text(
          "City",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: formTextFieldInputDecoration(
            hintText: "City",
          ),
          readOnly: true,
          controller: _cityController,
        ),
        const SizedBox(height: 20),

        //state
        Text(
          "State",
          style: formFieldHeadingTextStyle(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          readOnly: true,
          decoration: formTextFieldInputDecoration(
            hintText: "State",
          ),
          controller: _stateController,
        ),
        const SizedBox(height: 20),

        //submit
        ElevatedButton(
          onPressed: () => _submit(),
          style: fullBlueButtonStyle(),
          child: const Text("Update"),
        ),
      ],
    );
  }
}
