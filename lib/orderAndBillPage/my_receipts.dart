import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
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
  // var receiptList = getReceiptsData();
  List<dynamic>? receiptList;
  DateTime? prevDate;

  AuthService authService = AuthService();

  void getAllReceipts() async {
    receiptList = await authService.getAllReceipts(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllReceipts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RootColumn(
        heading: transText(context).myReceipts,
        children: receiptList == null
            ? [
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ]
            : receiptList!.isEmpty
                ? [
                    const Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ]
                : [
                    dividerHeading(
                        receiptList!.first["paymentDate"].split("T")[0]),
                    // dividerHeading((receiptList.isNotEmpty)
                    //     ? stringDateToFormattedString(receiptList.first.date)
                    //     : "No Receipts to Show"),
                    const SizedBox(height: 20),
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            receiptBoxBuilder(context, index),
                        separatorBuilder: (context, index) =>
                            dateSeperator(context, index),
                        itemCount: receiptList!.length),
                  ]);
  }

  Widget receiptBoxBuilder(BuildContext context, int index) {
    var recp = receiptList![index];
    return ReceiptWidget(
        orderNumber: recp["orderNumber"].toString(),
        // billNumber: recp.billNumber,
        company: recp["productName"],
        quantity: recp["orderQuantity"].toString(),
        // balanceQuantity: recp.balanceQuantity,
        content: recp,
        paidAmount: recp["totalPaidAmount"].toString(),
        amount: recp["totalOutstandingPayment"].toString(),
        billDownloadLink: "abcd",
        // billDownloadLink: recp.billDownloadLink,
        status: getStatusFromString("completed", context));
  }

  Widget dateSeperator(BuildContext context, int index) {
    var date = stringToDate(receiptList![index + 1].date);
    return (prevDate != null && DateUtils.isSameDay(date, prevDate))
        ? const SizedBox(height: 15)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 17),
            child: dividerHeading(dateToFormattedString(date)),
          );
  }
}
