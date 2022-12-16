import 'package:flutter/material.dart';
import 'package:m_steel/state_rates.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

class FactoryRateScreen extends StatefulWidget {
  const FactoryRateScreen({super.key});
  static const routeName = "/factoryRates";

  @override
  State<FactoryRateScreen> createState() => _FactoryRateScreenState();
}

class _FactoryRateScreenState extends State<FactoryRateScreen> {
  @override
  Widget build(BuildContext context) {
    return RootColumn(heading: transText(context).factoryRate, children: [
      Center(
        child: TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, StateRatesScreen.routeName),
          child: const Text("State Clicked"),
        ),
      )
    ]);
  }
}
