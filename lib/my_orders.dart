import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/order_details.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/order_statement_box.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  static const routeName = "/myOrders";

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final List<OrderDetailsData> sampleNewStatements =
          getSampleOrderStatementsNEW(),
      sampleOldStatements = getSampleOrderStatementsOLD();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppbar(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 3),
              headingText(transText(context).orderStatements),
              const SizedBox(height: 24),
              dividerHeading((sampleNewStatements.isNotEmpty
                  ? transText(context).newOrders
                  : "No New Orders")),
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
              dividerHeading((sampleOldStatements.isNotEmpty)
                  ? transText(context).previousOrders
                  : "No Previous Orders"),
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

  OrderStatementWidget statementBoxMaker(
      List<OrderDetailsData> statementList, int index) {
    return OrderStatementWidget(
      orderNumber: statementList[index].orderNumber,
      quantity: statementList[index].quantity,
      bookingRate: statementList[index].bookingRate,
      status: getStatusFromString(statementList[index].status, context),
      onTap: () {
        Navigator.pushNamed(context, OrderDetailsScreen.routeName,
            arguments: statementList[index]);
      },
    );
  }
}
