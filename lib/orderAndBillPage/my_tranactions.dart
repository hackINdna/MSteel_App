import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/transaction_box.dart';

class MyTransactionsScreen extends StatefulWidget {
  const MyTransactionsScreen({super.key});
  static const routeName = "/myTransactions";

  @override
  State<MyTransactionsScreen> createState() => _MyTransactionsScreenState();
}

class _MyTransactionsScreenState extends State<MyTransactionsScreen> {
  // var transactionList = getTransactionData();
  DateTime? prevDate;

  AuthService authService = AuthService();
  List<dynamic>? transactionList;

  void getAllTransactions() async {
    transactionList = await authService.getAllTransactions(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RootColumn(
        heading: transText(context).myTransactions,
        children: transactionList == null
            ? [
                const Center(
                  child: CircularProgressIndicator(),
                )
              ]
            : transactionList!.isEmpty
                ? [
                    const Center(
                      child: Text(
                        "No data found",
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
                        transactionList!.first["paymentDate"].split("T")[0]),
                    // dividerHeading((transactionList!.isNotEmpty)
                    //     ? stringDateToFormattedString(
                    //         transactionList.first.date)
                    //     : "No Transactions to Show"),
                    const SizedBox(height: 20),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          transactionBoxBuilder(context, index),
                      separatorBuilder: (context, index) =>
                          dateSeperator(context, index),
                      itemCount: transactionList!.length,
                    ),
                  ]);
  }

  Widget dateSeperator(BuildContext context, int index) {
    var date = stringToDate(transactionList![index + 1].date);
    return (prevDate != null && DateUtils.isSameDay(date, prevDate))
        ? const SizedBox(height: 15)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 17),
            child: dividerHeading(dateToFormattedString(date)),
          );
  }

  Widget transactionBoxBuilder(BuildContext context, int index) {
    var tran = transactionList![index];
    return TransactionWidget(
      productName: tran["productName"].toString(),
      quantity: tran["orderQuantity"].toString(),
      amount: tran["totalOutstandingPayment"].toString(),
      paid: tran["totalPaidAmount"].toString(),
      debit: false,
      status: getStatusFromString("completed", context),
    );
  }
}
