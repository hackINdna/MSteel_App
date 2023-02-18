import 'package:flutter/material.dart';
import 'package:m_steel/authScreen/biometric_auth.dart';
import 'package:m_steel/enquiryPage/enquire.dart';
import 'package:m_steel/factoryRatePage/factory_rate.dart';
import 'package:m_steel/factoryRatePage/state_rates.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/util/non_general.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var user = Provider.of<UserProvider>(context).user;
    print(user.businessType);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        drawer: homeDrawer(mediaQuery, context),
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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, EnquireScreen.routeName);
              },
              child: Text(
                transText(context).enquire,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, EnquireScreen.routeName);
            //   },
            //   icon: Text(
            //     transText(context).enquire,
            //     style: const TextStyle(fontSize: 13),
            //   ),
            // )
          ],
          // flexibleSpace: Container(
          //   decoration: gradientBoxDecoration(),
          // ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black26,
              height: 102,
              child: const Center(child: Text("Space for ad.")),
            ),
            //marquee
            SizedBox(
              // color: Colors.amber,
              height: mediaQuery.size.height * 0.044,
              child: Marquee(
                text:
                    "ure 30000 close    Mspipe 47000(close)      UK Rolling mile raipu",
                crossAxisAlignment: CrossAxisAlignment.end,
                style: const TextStyle(
                    fontSize: 13.4, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidht * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: user.businessType == ""
                  ? const Center(
                      child: Text(
                        "No Data",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: screenWidht,
                            height: screenHeight * 0.10,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  user.businessType == "B2B"
                                      ? FactoryRateScreen.routeName
                                      : StateRatesScreen.routeName,
                                );
                              },
                              child: Text(
                                user.businessType == "B2B"
                                    ? "Factory Rates"
                                    : user.businessType == "B2C"
                                        ? "Retail Rates"
                                        : "No Data",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            )),
            // TextButton(
            //     onPressed: () =>
            //         Navigator.pushNamed(context, BiometricAuthScreen.routeName),
            //     child: const Text("Biometric screen")),
            Container(
              color: Colors.black26,
              height: 102,
              child: const Center(child: Text("Space for ad.")),
            ),
          ],
        ));
  }
}
