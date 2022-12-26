import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bank_list.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({super.key});
  static const routeName = "/myBalance";

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {
  var bankList = [
    ["assets/images/bob_logo.png", "Bank of Baroda- 0000", "url"],
  ];
  @override
  Widget build(BuildContext context) {
    return RootColumn(
      heading: transText(context).myBalance,
      screenPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0.8),
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => BankListItem(
              image: bankList[index][0],
              title: bankList[index][1],
              url: bankList[index][2]),
          itemCount: bankList.length,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            color: Colors.black,
          ),
        ),
        const Divider(height: 0, color: Colors.black),
      ],
    );
  }
}
