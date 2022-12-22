import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:shared_preferences/shared_preferences.dart';

//making a static var set during startup by didChangeDependencies() for quickly accessing index next time
int currentLocaleIndex = 0;
//preference name
const String LANGUAGE_CODE = 'languageCode';

const String ENGLISH = 'en';
const String HINDI = 'hi';
const String TAMIL = 'ta';
const String TELUGU = 'te';
const String KANNADA = 'kn';
const String MALAYALAM = 'ml';
const String MARATHI = 'mr';
const String GUJRATI = 'gu';
const String BENGALI = 'bn';
const String PUNJABI = 'pa';
const String ASSAMESE = 'as';

//list of languages
const List<String> languageList = [
  "English",
  "Hindi",
  "Tamil",
  "Telugu",
  "Kannada",
  "Malayalam",
  "Bengali",
  "Marathi",
  "Gujarati",
  "Odiya", //saved as UK variant of english
  "Punjabi",
  "Assamese"
];
//list of locales in same order as languageList
const List<Locale> languageLocales = [
  Locale(ENGLISH, INDIA),
  Locale(HINDI, INDIA),
  Locale(TAMIL, INDIA),
  Locale(TELUGU, INDIA),
  Locale(KANNADA, INDIA),
  Locale(MALAYALAM, INDIA),
  Locale(BENGALI, INDIA),
  Locale(MARATHI, INDIA),
  Locale(GUJRATI, INDIA),
  Locale(ENGLISH, 'UK'),
  Locale(PUNJABI, INDIA),
  Locale(ASSAMESE, INDIA),
];
//country code
const String INDIA = 'IN';

Future<Locale> saveLocale(int? languageIndex) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(LANGUAGE_CODE, languageIndex ?? 0);
  return languageLocales[languageIndex ?? 0];
}

Future<int> getSavedLocaleIndex() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int index = prefs.getInt(LANGUAGE_CODE) ?? 0;
  return index;
}

AppLocalizations transText(BuildContext context) {
  return AppLocalizations.of(context)!;
}
