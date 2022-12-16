import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({super.key});
  static const routeName = "/myBalance";

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return RootColumn(heading: transText(context).myBalance, children: []);
  }
}
