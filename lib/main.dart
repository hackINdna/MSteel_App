import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:m_steel/providerClass/stockProvider.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/routes/generated_routes.dart';
import 'package:m_steel/splashScreen/splash_screen.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => StockProvider(),
    )
  ], child: const TheApplication()));
}

class TheApplication extends StatefulWidget {
  const TheApplication({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _TheApplicationState? state =
        context.findAncestorStateOfType<_TheApplicationState>();
    state?.setLocale(locale);
  }

  @override
  State<TheApplication> createState() => _TheApplicationState();
}

class _TheApplicationState extends State<TheApplication> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void disableScreenShots() =>
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  @override
  void didChangeDependencies() {
    getSavedLocaleIndex().then((localeIndex) {
      setLocale(languageLocales[localeIndex]);
      currentLocaleIndex = localeIndex;
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    disableScreenShots();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MSteel",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // supportedLocales: languageLocales,
      locale: _locale,
      theme: ThemeData(
        scaffoldBackgroundColor: offWhiteBG,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        fontFamily: "DMSans",
      ),
      onGenerateRoute: (settings) => generatedRoute(settings),
      home: const SplashScreen(),
    );
  }
}
