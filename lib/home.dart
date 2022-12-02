import 'package:flutter/material.dart';
import 'package:m_steel/my_orders.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/drawer_list_tile.dart';
import 'package:m_steel/widgets/language_changer_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _updateProfileButton() {}

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      drawer: Drawer(
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
                    backgroundImage:
                        const AssetImage("assets/images/disp_dp.jpg"),
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
                                    onPressed: () => _updateProfileButton(),
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
              title: "My Orders",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyOrdersScreen.routeName);
              },
            ),
            DrawerListTile(
              title: "My Bills",
              onTap: () {
                print("My bills");
              },
            ),
            DrawerListTile(
              title: "My Transactions",
              onTap: () {
                print("My Transactions");
              },
            ),
            DrawerListTile(
              title: "My Receipts",
              onTap: () {
                print("My Transactions");
              },
            ),
            DrawerListTile(
              title: "Change language",
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
              title: "Stock Statements",
              onTap: () {
                print("Stock statements");
              },
            ),
            DrawerListTile(
              title: "Contact Admin",
              onTap: () {
                print("Contact admin");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: appBlueBg,
        elevation: 3,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.more_vert),
          );
        }),
        title: appBarTitle(),
        actionsIconTheme: IconThemeData(size: mediaQuery.size.width * 0.15),
        actions: [
          IconButton(
            onPressed: () {
              print("enquire page");
            },
            icon: const Text(
              "Enquire",
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
        // flexibleSpace: Container(
        //   decoration: gradientBoxDecoration(),
        // ),
      ),
      body: Center(child: Text("Home Screen")),
    );
  }
}
