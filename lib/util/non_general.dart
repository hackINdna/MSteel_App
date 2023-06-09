import 'package:flutter/material.dart';
import 'package:m_steel/authScreen/login.dart';
import 'package:m_steel/orderAndBillPage/my_balance.dart';
import 'package:m_steel/orderAndBillPage/my_bills.dart';
import 'package:m_steel/orderAndBillPage/my_orders.dart';
import 'package:m_steel/orderAndBillPage/my_receipts.dart';
import 'package:m_steel/orderAndBillPage/my_tranactions.dart';
import 'package:m_steel/factoryRatePage/stock_statements.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/subscriptionPage/subscription_plans.dart';
import 'package:m_steel/profilePage/update_profile.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/contact_admin_dialog.dart';
import 'package:m_steel/widgets/drawer_list_tile.dart';
import 'package:m_steel/widgets/language_changer_container.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//home drawer
Drawer homeDrawer(MediaQueryData mediaQuery, BuildContext context) {
  var user = Provider.of<UserProvider>(context).user;
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  //var mediaQuery = MediaQuery.of(context);
  // void updateProfileButton() {}
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
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
                  InkWell(
                    onTap: () => Navigator.popAndPushNamed(
                        context, UpdateProfileScreen.routeName),
                    child: Container(
                        width: (mediaQuery.size.width * 0.095) * 2,
                        height: (mediaQuery.size.width * 0.095) * 2,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey),
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: user.profilePic == ""
                            ? Icon(Icons.person,
                                color: Colors.grey, size: screenHeight * 0.05)
                            : Image.network(
                                user.profilePic,
                                fit: BoxFit.cover,
                              )),
                  ),
                  //user details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //name
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          //phone number
                          Text(
                            user.number,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "INR ${user.balanceAmount}",
                                style: const TextStyle(
                                  fontSize: 14.3,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // SizedBox(
                              //   height: 21,
                              //   //parent was container earlier for padding
                              //   //padding: const EdgeInsets.only(right: 12),
                              //   child: ElevatedButton(
                              //       onPressed: () => updateProfileButton(),
                              //       style: ElevatedButton.styleFrom(
                              //           backgroundColor: themeColors.last),
                              //       child: const Text(
                              //         "Update",
                              //         style: TextStyle(
                              //           fontSize: 12,
                              //         ),
                              //       )),
                              // )
                            ],
                          ),
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
                Navigator.pop(context);
                Navigator.pushNamed(context, MyBillsScreen.routeName);
              },
            ),
            DrawerListTile(
              title: transText(context).myTransactions,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyTransactionsScreen.routeName);
              },
            ),
            DrawerListTile(
              title: transText(context).myReceipts,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyReceiptsScreen.routeName);
              },
            ),
            DrawerListTile(
              title: transText(context).changeLanguage,
              onTap: () {
                //Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: Material(
                        color: Colors.transparent,
                        child: LanguageChangeDialogContainer(),
                      ),
                    );
                  },
                );
              },
            ),
            DrawerListTile(
              title: transText(context).stockStatements,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, StockStatementScreen.routeName);
              },
            ),
            DrawerListTile(
              title: transText(context).myBalance,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyBalanceScreen.routeName);
              },
            ),
            DrawerListTile(
              title: transText(context).subscriptionPlans,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SubscriptionScreen.routeName);
              },
            ),
            DrawerListTile(
              title: transText(context).contactAdmin,
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => const ContactAdminDialog()),
            ),
            // const Expanded(
            //   child: SizedBox(),
            // ),
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.2),
                    ),
                    content: Text(
                      transText(context).logoutMessage,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 17),
                    ),
                    actions: [
                      alertOkTextButton(
                        context,
                        text: transText(context).cancel,
                        foregroundColor: const Color(0xffBABCBC),
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            var prefs = await SharedPreferences.getInstance();
                            prefs.clear().then((value) =>
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginScreen.routeName, (route) => false));
                          },
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          child: Text(
                            transText(context).ok,
                          )),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
