import 'package:flutter/material.dart';
import 'package:m_steel/enquire.dart';
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
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EnquireScreen.routeName);
              },
              icon: Text(
                transText(context).enquire,
                style: const TextStyle(fontSize: 13),
              ),
            )
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
              height: mediaQuery.size.height * 0.035,
              child: Marquee(
                text:
                    "ure 30000 close    Mspipe 47000(close)      UK Rolling mile raipu",
                crossAxisAlignment: CrossAxisAlignment.end,
                style: const TextStyle(
                    fontSize: 14.3, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                      print("clicked index = $index");
                    },
                    child: Center(
                      child: Text(
                        (index == 0) ? "Ex- Depot Rates" : "Ex- Plant Rates",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
            Container(
              color: Colors.black26,
              height: 102,
              child: const Center(child: Text("Space for ad.")),
            ),
          ],
        ));
  }
}
