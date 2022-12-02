import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

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
      appBar: AppBar(
        backgroundColor: appBlueBg,
        elevation: 3,
        title: appBarTitle(),
        centerTitle: true,
      ),
      body: const Center(child: Text("My Orders")),
    );
  }
}
