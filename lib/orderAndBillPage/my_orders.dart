import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/orderAndBillPage/order_details.dart';
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

  List<dynamic>? orderList;
  List<dynamic>? newOrderList;
  List<dynamic>? oldOrderList;

  AuthService authService = AuthService();

  Future<void> getAllOrders() async {
    orderList = await authService.getAllOrders(context: context);
    if (mounted) {
      setState(() {
        newOrderList = orderList![0];
        oldOrderList = orderList![1];
      });
    }
  }

  @override
  void initState() {
    getAllOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppbar(),
      body: orderList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orderList!.isEmpty
              ? const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38),
                  ),
                )
              : SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 20),
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
                              statementBoxMaker(newOrderList!, index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: newOrderList!.length,
                        ),
                        const SizedBox(height: 26),
                        dividerHeading((oldOrderList!.isNotEmpty)
                            ? transText(context).previousOrders
                            : "No Previous Orders"),
                        const SizedBox(height: 20),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              statementBoxMaker(oldOrderList!, index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: oldOrderList!.length,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  OrderStatementWidget statementBoxMaker(List<dynamic> orderList, int index) {
    return OrderStatementWidget(
      orderNumber: orderList[index]["orderNumber"].toString(),
      quantity: orderList[index]["orderQuantity"].toString(),
      bookingRate: orderList[index]["orderAmount"].toString(),
      status: getStatusFromString(orderList[index]["status"], context),
      onTap: () {
        Navigator.pushNamed(context, OrderDetailsScreen.routeName,
            arguments: orderList[index]);
      },
    );
  }
}
