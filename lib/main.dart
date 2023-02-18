import "package:flutter/material.dart";
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:m_steel/orderAndBillPage/add_card.dart';
import 'package:m_steel/authScreen/biometric_auth.dart';
import 'package:m_steel/enquiryPage/enquire.dart';
import 'package:m_steel/factoryRatePage/factory_rate.dart';
import 'package:m_steel/authScreen/forgot_password.dart';
import 'package:m_steel/homePage/home.dart';
import 'package:m_steel/authScreen/login.dart';
import 'package:m_steel/paymentPage/make_payment.dart';
import 'package:m_steel/orderAndBillPage/my_balance.dart';
import 'package:m_steel/orderAndBillPage/my_bills.dart';
import 'package:m_steel/orderAndBillPage/my_orders.dart';
import 'package:m_steel/orderAndBillPage/my_receipts.dart';
import 'package:m_steel/orderAndBillPage/my_tranactions.dart';
import 'package:m_steel/orderAndBillPage/order_details.dart';
import 'package:m_steel/orderAndBillPage/order_whatsapp.dart';
import 'package:m_steel/authScreen/otp_verification.dart';
import 'package:m_steel/authScreen/reset_password.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/routes/generated_routes.dart';
import 'package:m_steel/authScreen/signup.dart';
import 'package:m_steel/splashScreen/splash_screen.dart';
import 'package:m_steel/factoryRatePage/state_rates.dart';
import 'package:m_steel/factoryRatePage/stock_statements.dart';
import 'package:m_steel/subscriptionPage/subscription_plans.dart';
import 'package:m_steel/profilePage/update_profile.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/authScreen/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
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
