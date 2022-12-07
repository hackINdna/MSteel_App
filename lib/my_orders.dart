import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';
import 'package:m_steel/widgets/order_statement_box.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  static const routeName = "/myOrders";

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late final List<OrderStatementData> sampleNewStatements, sampleOldStatements;
  @override
  Widget build(BuildContext context) {
    sampleNewStatements = getSampleOrderStatementsNEW(context);
    sampleOldStatements = getSampleOrderStatementsOLD(context);
    return Scaffold(
      appBar: generalAppbar(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              headingText(transText(context).orderStatements),
              const SizedBox(height: 26),
              dividerHeading(transText(context).newOrders),
              const SizedBox(height: 20),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    statementBoxMaker(sampleNewStatements, index),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: sampleNewStatements.length,
              ),
              const SizedBox(height: 26),
              dividerHeading(transText(context).previousOrders),
              const SizedBox(height: 20),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    statementBoxMaker(sampleOldStatements, index),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: sampleOldStatements.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  OrderStatement statementBoxMaker(
      List<OrderStatementData> statementList, int index) {
    return OrderStatement(
      orderNumber: statementList[index].orderNumber,
      quantity: statementList[index].quantity,
      bookingRate: statementList[index].bookingRate,
      status: statementList[index].status,
      onTap: () {
        print("tapped");
      },
    );
  }
}
