import "package:flutter/material.dart";
import 'package:m_steel/main.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/search_box.dart';

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
  final searchController = TextEditingController();
  _changeLanguage() {
    //pop dialog and drawer
    int count = 0;
    Navigator.of(context).popUntil(
      (route) => count++ >= 2,
    );
    //changed lang below
    saveLocale(_groupValue);
    TheApplication.setLocale(context, languageLocales[_groupValue]);
    currentLocaleIndex = _groupValue;
  }

  void _updateValue(int? value) {
    if (_groupValue != value) {
      setState(() {
        _groupValue = value ?? 0;
      });
    }
  }

  // void _valueChanged(String value) {
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    //get saved value from shared prefs
    _groupValue = currentLocaleIndex;
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 21),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SearchTextField(
                controller: searchController,
                onChanged: (value) {
                  print("chnaged to $value");
                },
              ),
            ),
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
