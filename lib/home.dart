import 'package:flutter/material.dart';
import 'package:m_steel/biometric_auth.dart';
import 'package:m_steel/enquire.dart';
import 'package:m_steel/factory_rate.dart';
import 'package:m_steel/state_rates.dart';
import 'package:m_steel/util/general.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/util/non_general.dart';
import 'package:marquee/marquee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 6),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 11,
                  mainAxisExtent: 98,
                ),
                itemCount: 2,
                itemBuilder: (context, index) => Card(
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(index == 0
                          ? FactoryRateScreen.routeName
                          : StateRatesScreen.routeName);
                    },
                    child: Center(
                      child: Text(
                        (index == 0) ? "Ex- Plant Rates" : "Ex- Depot Rates",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
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
