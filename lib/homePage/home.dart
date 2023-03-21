import 'dart:async';

import 'package:flutter/material.dart';
import 'package:m_steel/enquiryPage/enquire.dart';
import 'package:m_steel/factoryRatePage/factory_rate.dart';
import 'package:m_steel/factoryRatePage/retailRates.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/util/non_general.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController1;
  late PageController _pageController2;
  late PageController _pageController3;

  late Timer _timer;
  late Timer _timer1;

  @override
  void initState() {
    var uu = Provider.of<UserProvider>(context, listen: false).user;
    _pageController1 = PageController(initialPage: 0);
    _pageController2 = PageController(initialPage: 0);
    _pageController3 = PageController(initialPage: 0);

    _timer1 = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController3.page!.round() == uu.stock!.length - 1) {
        _pageController3.animateToPage(0,
            duration: const Duration(seconds: 3), curve: Curves.ease);
      } else {
        _pageController3.nextPage(
            duration: const Duration(seconds: 3), curve: Curves.ease);
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController1.page!.round() == uu.advertisements!.length - 1 &&
          _pageController2.page!.round() == uu.advertisements!.length - 1) {
        _pageController1.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
        _pageController2.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      } else {
        _pageController1.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
        _pageController2.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer1.cancel();
    _pageController1.dispose();
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var user = Provider.of<UserProvider>(context).user;
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
              child: PageView.builder(
                controller: _pageController1,
                itemCount: user.advertisements!.length,
                itemBuilder: (context, index) {
                  var link = user.advertisements![index]["url"];
                  return InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(link))) {
                        await launchUrl(Uri.parse(link),
                            mode: LaunchMode.externalApplication);
                      } else {
                        showSnackBar(context, 'Could not launch $link');
                      }
                    },
                    child: Image.network(
                      user.advertisements![index]["image"],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            //marquee
            SizedBox(
              // color: Colors.amber,
              height: mediaQuery.size.height * 0.044,
              width: screenWidht,
              child: PageView.builder(
                  controller: _pageController3,
                  itemCount: user.stock!.length,
                  itemBuilder: (context, index) {
                    return Marquee(
                      text:
                          "${user.stock![index]["stateName"]}-${user.stock![index]["stockName"]} - INR ${user.stock![index]["basic"]}",
                      crossAxisAlignment: CrossAxisAlignment.start,
                      style: const TextStyle(
                          fontSize: 13.4, fontWeight: FontWeight.bold),
                      scrollAxis: Axis.horizontal,
                      blankSpace: 20.0,
                      velocity: 50.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      showFadingOnlyWhenScrolling: true,
                      fadingEdgeStartFraction: 0.1,
                      fadingEdgeEndFraction: 0.1,
                    );
                  }),
              // child: Marquee(
              //         text:
              //             "${user.stock![index]["stateName"]}-${user.stock![index]["stockName"]} - INR ${user.stock![index]["stockPrice"]}",
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         style: const TextStyle(
              //             fontSize: 13.4, fontWeight: FontWeight.bold),
              //         scrollAxis: Axis.horizontal,
              //         blankSpace: 20.0,
              //         velocity: 50.0,
              //         pauseAfterRound: const Duration(seconds: 1),
              //         showFadingOnlyWhenScrolling: true,
              //         fadingEdgeStartFraction: 0.1,
              //         fadingEdgeEndFraction: 0.1,
              //       ),
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
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                user.businessType == "B2B"
                                    ? FactoryRateScreen.routeName
                                    : RetailRates.routeName,
                              );
                            },
                            child: Container(
                              width: screenWidht,
                              height: screenHeight * 0.10,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
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
              child: PageView.builder(
                controller: _pageController2,
                itemCount: user.advertisements!.length,
                itemBuilder: (context, index) {
                  var link = user.advertisements![index]["url"];
                  return InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(link))) {
                        await launchUrl(Uri.parse(link),
                            mode: LaunchMode.externalApplication);
                      } else {
                        showSnackBar(context, 'Could not launch $link');
                      }
                    },
                    child: Image.network(
                      user.advertisements![index]["image"],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
