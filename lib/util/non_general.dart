import 'package:flutter/material.dart';
import 'package:m_steel/login.dart';
import 'package:m_steel/my_orders.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/drawer_list_tile.dart';
import 'package:m_steel/widgets/language_changer_container.dart';

//home drawer
Drawer homeDrawer(MediaQueryData mediaQuery, BuildContext context) {
  //var mediaQuery = MediaQuery.of(context);
  void updateProfileButton() {}
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //header
        Container(
          padding: EdgeInsets.only(
            top: mediaQuery.padding.top + 17,
            left: 15,
            right: 15,
            bottom: 20,
          ),
          child: Row(
            children: [
              //image
              CircleAvatar(
                radius: mediaQuery.size.width * 0.095,
                backgroundImage: const AssetImage("assets/images/disp_dp.jpg"),
              ),
              //user details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //name
                      const Text(
                        "Terrence Stracke",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      //phone number
                      const Text("4545 45 4545"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "₹ 0",
                            style: TextStyle(
                              fontSize: 14.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 21,
                            //parent was container earlier for padding
                            //padding: const EdgeInsets.only(right: 12),
                            child: ElevatedButton(
                                onPressed: () => updateProfileButton(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColors.last),
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
        DrawerListTile(
          title: transText(context).myOrders,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MyOrdersScreen.routeName);
          },
        ),
        DrawerListTile(
          title: transText(context).myBills,
          onTap: () {
            print("My bills");
          },
        ),
        DrawerListTile(
          title: transText(context).myTransactions,
          onTap: () {
            print("My Transactions");
          },
        ),
        DrawerListTile(
          title: transText(context).myReceipts,
          onTap: () {
            print("My Receipt");
          },
        ),
        DrawerListTile(
          title: transText(context).changeLanguage,
          onTap: () {
            //Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: const LanguageChangeDialogContainer(),
                );
              },
            );
          },
        ),
        DrawerListTile(
          title: transText(context).stockStatements,
          onTap: () {
            print("Stock statements");
          },
        ),
        DrawerListTile(
          title: transText(context).contactAdmin,
          onTap: () {
            print("Contact admin");
          },
        ),
        const Expanded(
          child: SizedBox(),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
        DrawerListTile(
          title: transText(context).logout,
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: alertBoxShape(),
                title: Text(
                  transText(context).logout,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(transText(context).logoutMessage),
                actions: [
                  alertOkTextButton(context, text: transText(context).cancel),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        //log user out
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      },
                      child: Text(transText(context).ok)),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
