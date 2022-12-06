import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  static const routeName = "/myOrders";

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
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
            headingText(transText(context).orderStatements),
            const SizedBox(height: 26),
          ],
        ),
      )),
    );
  }
}
