import 'package:flutter/material.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

import 'widgets/subscription_dialog.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});
  static const routeName = "/subscriptionPlans";

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  var subscriptionData = getSubscriptionData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: offWhiteBG,
        foregroundColor: appBlueBg,
        title: Text(
          transText(context).subscriptions,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 29),
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 21),
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          SubscriptionDialog(subscriptionData[index]),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.1),
                      color: Colors.white,
                      border: Border.all(color: boxBorderColor, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 158, 158, 158), //New
                          blurRadius: 5.9,
                          spreadRadius: -3.5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "MSteel",
                              style: TextStyle(
                                  color: appBlueBg,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 26,
                              child: Chip(
                                visualDensity: VisualDensity.compact,
                                label: Text(
                                  subscriptionData[index].title,
                                  style: const TextStyle(
                                      fontSize: 9.8, color: Colors.white),
                                ),
                                backgroundColor: appBlueBg2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subscriptionData[index].subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11.4, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
            itemCount: 2),
      ),
    );
  }
}
