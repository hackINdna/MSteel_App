import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bank_list.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:provider/provider.dart';

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
  bool _visible = false;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return RootColumn(
      heading: transText(context).myBalance,
      screenPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0.8),
      children: [
        // ListView.separated(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) => BankListItem(
        //       image: bankList[index][0],
        //       title: bankList[index][1],
        //       url: bankList[index][2]),
        //   itemCount: bankList.length,
        //   separatorBuilder: (context, index) => const Divider(
        //     height: 0,
        //     color: Colors.black,
        //   ),
        // ),
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 8.8),
          dense: true,
          visualDensity: VisualDensity.comfortable,
          // leading: CircleAvatar(backgroundImage: AssetImage(image), radius: 25.1),
          title: const Text(
            "Balance left:",
            // textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.4),
          ),
          trailing: !_visible
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                  child: Text(transText(context).checkBalance,
                      style: const TextStyle(fontSize: 13.2, color: appBlueBg)),
                )
              : Text(
                  "INR ${user.balanceAmount}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
        ),
        const Divider(height: 0, color: Colors.black),
      ],
    );
  }
}
