import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import "package:path/path.dart" as p;
import 'package:provider/provider.dart';

class EnquireScreen extends StatefulWidget {
  const EnquireScreen({super.key});

  static const routeName = "/enquire";

  @override
  State<EnquireScreen> createState() => _EnquireScreenState();
}

class _EnquireScreenState extends State<EnquireScreen> {
  File? image;
  late TextEditingController _enquireTextController;
  bool _imageSelected = false;
  String? _enquireFieldError;
  bool? submittedSuccessfully;
  void _onSubmit() async {
    navigatorPop() => Navigator.pop(context);
    showCircularProgressIndicator(context: context);
    submittedSuccessfully = await authService.sendEnquiry(
      context: context,
      enquiryMsg: _enquireTextController.text,
      enquiryImage: image == null ? "" : image!.path,
    );

    navigatorPop();

    setState(() {
      var len = _enquireTextController.text.trim().length;
      // if (len <= 0) {
      //   _enquireFieldError = transText(context).emptyFieldError;
      //   return;
      // } else if (len < 20) {
      //   _enquireFieldError = transText(context).elaborationRequiredError;
      //   return;
      // } else {
      //   _enquireFieldError = null;
      // }

      //on submitted:
      if (submittedSuccessfully!) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                      transText(context).enquireSubmittedSuccessfullyTitle),
                  content: Text(transText(context)
                      .enquireSubmittedSuccessfullyDescription),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _enquireTextController.clear();
                            _imageSelected = false;
                          });
                        },
                        child: Text(transText(context).ok))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(transText(context).enquireSubmittedFailedTitle),
                  content: Text(transText(context)
                      .enquireSubmittedFailedDescription("-error here-")),
                  actions: [alertOkTextButton(context)],
                ));
      }
    });
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

  void getAndSetImage(ImageSource src) async {
    Navigator.pop(context);
    var image = await pickImage(src);
    if (image != null) {
      setState(() {
        _imageSelected = true;
        this.image = File(image.path);
      });
    }
  }

  bool isLoading = true;

  AuthService authService = AuthService();

  void getAllEnquiry() async {
    await authService.getUserEnquiries(context: context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _enquireTextController = TextEditingController();
    getAllEnquiry();
  }

  @override
  void dispose() {
    super.dispose();
    _enquireTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var user = Provider.of<UserProvider>(context).user;
    // print(user.enquiry!.last["admin"]);
    return Scaffold(
      appBar: generalAppbar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.89,
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    headingText(transText(context).enquire),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: _enquireTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: transText(context).enquireFieldHint,
                        //hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(width: 1.2, color: Colors.cyan),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.redAccent),
                        ),
                        errorText: _enquireFieldError,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    OutlinedButton.icon(
                      onPressed: () async {
                        openModalBottomSheet(
                          context,
                          _deleteSelectedImage,
                          getAndSetImage,
                        );
                      },
                      icon: const Icon(Icons.upload),
                      label: _imageSelected
                          ? Text(p.basename(image!.path).replaceRange(
                              0,
                              p.basename(image!.path).lastIndexOf("picker") + 6,
                              ""))
                          : Text(transText(context).uploadPhoto),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(
                            color: themeColors.last,
                            width: 2,
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.maxFinite, 47)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    ElevatedButton(
                      onPressed: () => _onSubmit(),
                      style: fullBlueButtonStyle(),
                      child: Text(transText(context).send),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      children: [
                        const Text(
                          "Replies",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: const Divider(
                            color: Color(0xffA6A6A6),
                            thickness: 1,
                          ),
                        )),
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: screenWidth,
                        margin: EdgeInsets.only(top: screenHeight * 0.01),
                        // color: Colors.blue,
                        child: ListView.builder(
                          itemCount: user.enquiry!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 0,
                                  leading: CircleAvatar(
                                    radius: screenHeight * 0.04,
                                    child: Container(
                                      width: screenHeight * 0.8,
                                      height: screenHeight * 0.8,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        user.enquiry![index]["user"]["images"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    user.enquiry![index]["user"]["enquiry"],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 4,
                                  ),
                                  subtitle:
                                      (user.enquiry![index]["admin"] != null)
                                          ? Text(
                                              user.enquiry![index]["admin"]
                                                  ["enquiry"],
                                            )
                                          : const Text(""),
                                  // subtitle: const Text(
                                  //   "Pretium aenean quis diam euismod. Scelerisque euismod dui montes ultricies dignissim nunc sed vulputate. Id odio nulla sem tempor nunc quam felis egestas sed.",
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ),
                                const Divider()
                              ],
                            );
                          },
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
