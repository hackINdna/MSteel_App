import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/my_bills.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/order_details_box.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});
  static const routeName = "/orderDetails";
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final OrderDetailsData orderDetails =
        ModalRoute.of(context)!.settings.arguments as OrderDetailsData;
    return RootColumn(heading: "Order Details", children: [
      Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, MyBillsScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appBlueBg,
              fixedSize: const Size.fromWidth(60),
              padding: const EdgeInsets.all(0),
            ),
            child: Text(
              transText(context).myBills,
              style: const TextStyle(fontSize: 11.1),
            ),
          ),
        ),
      ),
      dividerHeading(stringDateToFormattedString(orderDetails.date)),
      const SizedBox(height: 24),
      OrderDetailsWidget(
        orderNumber: orderDetails.orderNumber,
        bookingRate: orderDetails.bookingRate,
        quantity: orderDetails.quantity,
        company: orderDetails.company,
        balanceQuantity: orderDetails.balanceQuantity,
        status: getStatusFromString(orderDetails.status, context),
      ),
    ]);
  }
}
