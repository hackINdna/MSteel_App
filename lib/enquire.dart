import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bottom_sheet_icon_button.dart';
import "package:path/path.dart" as p;

class EnquireScreen extends StatefulWidget {
  const EnquireScreen({super.key});

  static const routeName = "/enquire";

  @override
  State<EnquireScreen> createState() => _EnquireScreenState();
}

class _EnquireScreenState extends State<EnquireScreen> {
  File? image;
  final _enquireTextController = TextEditingController();
  bool _imageSelected = false;
  String? _enquireFieldError = null;
  void _onSubmit() {
    setState(() {
      var len = _enquireTextController.text.trim().length;
      if (len <= 0) {
        _enquireFieldError = transText(context).emptyFieldError;
        return;
      } else if (len < 20) {
        _enquireFieldError = transText(context).elaborationRequiredError;
        return;
      } else {
        _enquireFieldError = null;
      }
      //submitting
      bool submittedSuccessfully = true;

      //on submitted:
      if (submittedSuccessfully) {
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

  @override
  void dispose() {
    super.dispose();
    _enquireTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              headingText(transText(context).enquire),
              const SizedBox(height: 26),
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
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.redAccent),
                  ),
                  errorText: _enquireFieldError,
                ),
              ),
              const SizedBox(height: 20),
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
                    ? Text(p.basename(image!.path).replaceRange(0,
                        p.basename(image!.path).lastIndexOf("picker") + 6, ""))
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
              const SizedBox(height: 56),
              ElevatedButton(
                onPressed: () => _onSubmit(),
                style: fullBlueButtonStyle(),
                child: Text(transText(context).send),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
