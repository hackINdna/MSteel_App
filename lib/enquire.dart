import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class EnquireScreen extends StatefulWidget {
  const EnquireScreen({super.key});

  static const routeName = "/enquire";

  @override
  State<EnquireScreen> createState() => _EnquireScreenState();
}

class _EnquireScreenState extends State<EnquireScreen> {
  final _enquireTextController = TextEditingController();
  String? _enquireFieldError = null;
  void _onSubmit() {
    setState(() {
      var len = _enquireTextController.text.trim().length;
      if (len <= 0) {
        _enquireFieldError = "Field cannot be Empty.";
        return;
      } else if (len < 20) {
        _enquireFieldError = "A little more elaboration required.";
        return;
      } else {
        _enquireFieldError = null;
      }
      //submitting
      bool submittedSuccessfully = false;

      //on submitted:
      if (submittedSuccessfully) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                      transText(context).enquireSubmittedSuccessfullyTitle),
                  content: Text(transText(context)
                      .enquireSubmittedSuccessfullyDescription),
                  actions: [alertOkTextButton(context)],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(transText(context).enquireSubmittedFailedTitle),
                  content: Text(transText(context)
                      .enquireSubmittedFailedDescription("err")),
                  actions: [alertOkTextButton(context)],
                ));
      }
    });
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
                onPressed: () => _onSubmit(),
                icon: const Icon(Icons.upload),
                label: Text(transText(context).uploadPhoto),
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
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: () => _onSubmit(),
                style: fullBlueButtonStyle(),
                child: Text(transText(context).send),
              )
            ],
          ),
        ),
      ),
    );
  }
}
