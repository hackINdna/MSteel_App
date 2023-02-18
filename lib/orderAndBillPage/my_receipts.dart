import 'package:flutter/material.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/receipt_box.dart';

class MyReceiptsScreen extends StatefulWidget {
  const MyReceiptsScreen({super.key});
  static const routeName = "/myReceipts";

  @override
  State<MyReceiptsScreen> createState() => _MyReceiptsScreenState();
}

class _MyReceiptsScreenState extends State<MyReceiptsScreen> {
  var receiptList = getReceiptsData();
  DateTime? prevDate;
  @override
  Widget build(BuildContext context) {
    return RootColumn(heading: transText(context).myReceipts, children: [
      dividerHeading((receiptList.isNotEmpty)
          ? stringDateToFormattedString(receiptList.first.date)
          : "No Receipts to Show"),
      const SizedBox(height: 20),
      ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => receiptBoxBuilder(context, index),
          separatorBuilder: (context, index) => dateSeperator(context, index),
          itemCount: receiptList.length),
    ]);
  }

  Widget receiptBoxBuilder(BuildContext context, int index) {
    var recp = receiptList[index];
    return ReceiptWidget(
        orderNumber: recp.orderNumber,
        billNumber: recp.billNumber,
        company: recp.company,
        quantity: recp.quantity,
        balanceQuantity: recp.balanceQuantity,
        bookingRate: recp.bookingRate,
        amount: recp.amount,
        billDownloadLink: recp.billDownloadLink,
        status: getStatusFromString(recp.status, context));
  }

  Widget dateSeperator(BuildContext context, int index) {
    var date = stringToDate(receiptList[index + 1].date);
    return (prevDate != null && DateUtils.isSameDay(date, prevDate))
        ? const SizedBox(height: 15)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 17),
            child: dividerHeading(dateToFormattedString(date)),
          );
  }
}
