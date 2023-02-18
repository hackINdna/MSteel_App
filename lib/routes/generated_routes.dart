import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:m_steel/authScreen/signup.dart';
import 'package:m_steel/splashScreen/splash_screen.dart';
import 'package:m_steel/factoryRatePage/state_rates.dart';
import 'package:m_steel/factoryRatePage/stock_statements.dart';
import 'package:m_steel/subscriptionPage/subscription_plans.dart';
import 'package:m_steel/profilePage/update_profile.dart';
import 'package:m_steel/authScreen/welcome.dart';

Route<dynamic> generatedRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );

    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );

    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPasswordScreen(),
      );

    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ResetPasswordScreen(),
      );

    case OtpVerificationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OtpVerificationScreen(),
      );

    case BiometricAuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BiometricAuthScreen(),
      );

    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WelcomeScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case UpdateProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UpdateProfileScreen(),
      );

    case MyOrdersScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyOrdersScreen(),
      );

    case EnquireScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EnquireScreen(),
      );

    case MyBillsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyBillsScreen(),
      );

    case OrderDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderDetailsScreen(),
      );

    case MyTransactionsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyTransactionsScreen(),
      );

    case MyReceiptsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyReceiptsScreen(),
      );

    case FactoryRateScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FactoryRateScreen(),
      );

    case StateRatesScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StateRatesScreen(),
      );

    case MyBalanceScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyBalanceScreen(),
      );

    case SubscriptionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SubscriptionScreen(),
      );

    case StockStatementScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StockStatementScreen(),
      );

    case AddCardScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddCardScreen(),
      );

    case MakePaymentScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MakePaymentScreen(),
      );

    case PlaceOrderWhatsappScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PlaceOrderWhatsappScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("404 Error"),
          ),
        ),
      );
  }
}
