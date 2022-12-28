import "package:flutter/material.dart";
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:m_steel/add_card.dart';
import 'package:m_steel/biometric_auth.dart';
import 'package:m_steel/enquire.dart';
import 'package:m_steel/factory_rate.dart';
import 'package:m_steel/forgot_password.dart';
import 'package:m_steel/home.dart';
import 'package:m_steel/login.dart';
import 'package:m_steel/make_payment.dart';
import 'package:m_steel/my_balance.dart';
import 'package:m_steel/my_bills.dart';
import 'package:m_steel/my_orders.dart';
import 'package:m_steel/my_receipts.dart';
import 'package:m_steel/my_tranactions.dart';
import 'package:m_steel/order_details.dart';
import 'package:m_steel/otp_verification.dart';
import 'package:m_steel/place_order.dart';
import 'package:m_steel/reset_password.dart';
import 'package:m_steel/signup.dart';
import 'package:m_steel/splash_screen.dart';
import 'package:m_steel/state_rates.dart';
import 'package:m_steel/stock_statements.dart';
import 'package:m_steel/subscription_plans.dart';
import 'package:m_steel/update_profile.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/welcome.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const TheApplication());
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
      routes: {
        "/": (context) => const SplashScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        ForgotPasswordScreen.routeName: (context) =>
            const ForgotPasswordScreen(),
        ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
        OtpVerificationScreen.routeName: (context) =>
            const OtpVerificationScreen(),
        BiometricAuthScreen.routeName: (context) => const BiometricAuthScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
        MyOrdersScreen.routeName: (context) => const MyOrdersScreen(),
        EnquireScreen.routeName: (context) => const EnquireScreen(),
        MyBillsScreen.routeName: (context) => const MyBillsScreen(),
        OrderDetailsScreen.routeName: (context) => const OrderDetailsScreen(),
        MyTransactionsScreen.routeName: (context) =>
            const MyTransactionsScreen(),
        MyReceiptsScreen.routeName: (context) => const MyReceiptsScreen(),
        FactoryRateScreen.routeName: (context) => const FactoryRateScreen(),
        StateRatesScreen.routeName: (context) => const StateRatesScreen(),
        //PlaceOrderScreen.routeName: (context) => const PlaceOrderScreen(),
        MyBalanceScreen.routeName: (context) => const MyBalanceScreen(),
        SubscriptionScreen.routeName: (context) => const SubscriptionScreen(),
        StockStatementScreen.routeName: (context) =>
            const StockStatementScreen(),
        AddCardScreen.routeName: (context) => const AddCardScreen(),
        MakePaymentScreen.routeName: (context) => const MakePaymentScreen(),
      },
    );
  }
}

// class LocaleProvider with ChangeNotifier {
//   Locale? _locale;
//   Locale? get locale => _locale;

//   void setLocale(Locale locale) {
//     if (!AppLocalizations.supportedLocales.contains(locale)) return;
//     _locale = locale;
//     notifyListeners();
//   }
// }
