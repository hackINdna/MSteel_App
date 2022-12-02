import "package:flutter/material.dart";
import 'package:m_steel/util/general.dart';

class LanguageChangeDialogContainer extends StatefulWidget {
  const LanguageChangeDialogContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageChangeDialogContainer> createState() =>
      _LanguageChangeDialogContainerState();
}

class _LanguageChangeDialogContainerState
    extends State<LanguageChangeDialogContainer> {
  late int _groupValue;

  _changeLanguage() {
    //pop dialog and drawer
    int count = 0;
    Navigator.of(context).popUntil(
      (route) => count++ >= 2,
    );
    //changed lang below
    print("changing to ${languageList[_groupValue]}");
  }

  void _updateValue(int? value) {
    if (_groupValue != value) {
      setState(() {
        _groupValue = value ?? 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //get saved value from shared prefs
    _groupValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: languageList.length,
              itemBuilder: (context, index) => ListTile(
                visualDensity: VisualDensity.compact,
                leading: Radio(
                  value: index,
                  groupValue: _groupValue,
                  onChanged: (value) => _updateValue(value),
                ),
                title: Text(languageList[index]),
                onTap: () => _updateValue(index),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => _changeLanguage(),
                style: TextButton.styleFrom(
                    backgroundColor: themeColors.last,
                    foregroundColor: Colors.white),
                child: const Text("Ok"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
