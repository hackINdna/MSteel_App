import "package:flutter/material.dart";
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bill_box.dart';

class MyBillsScreen extends StatefulWidget {
  const MyBillsScreen({super.key});
  static const routeName = "/myBills";

  @override
  State<MyBillsScreen> createState() => _MyBillsScreenState();
}

class _MyBillsScreenState extends State<MyBillsScreen> {
  // late List<BillData> billList;

  DateTime? prevDate;

  AuthService authService = AuthService();
  List<dynamic>? billList;

  void getAllBills() async {
    billList = await authService.getAllBills(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllBills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // billList = getBillData();
    // if (billList.isNotEmpty) {
    //   prevDate = stringToDate(billList.first.date);
    //   print("setting prev date to $prevDate");
    // }
    return Scaffold(
      appBar: generalAppbar(),
      body: billList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : billList!.isEmpty
              ? const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
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
                          headingText(transText(context).myBills),
                          const SizedBox(height: 24),
                          //condition based heading
                          dividerHeading(
                              billList!.first["billDate"].split("T")[0]),
                          // dividerHeading((billList.isNotEmpty)
                          //     ? stringDateToFormattedString(billList.first.date)
                          //     : "No Bills to Show"),
                          const SizedBox(height: 20),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                billListMaker(context, index),
                            separatorBuilder: (context, index) =>
                                dateSeperator(context, index),
                            itemCount: billList!.length,
                          ),
                        ]),
                  ),
                ),
    );
  }

  BillWidget billListMaker(BuildContext context, int index) {
    var bill = billList![index];
    return BillWidget(
      quantity: bill["orderQuantity"].toString(),
      // billNumber: bill.billNumber,
      amount: bill["totalAmount"].toString(),
      billDownloadLink: "abcd",
      content: bill,
      // billDownloadLink: bill.billDownloadLink,
      status: getStatusFromString("completed", context),
      // status: getStatusFromString(bill.status, context),
    );
  }

  Widget dateSeperator(BuildContext context, int index) {
    var date = stringToDate(billList![index + 1]["billDate"].split("T")[0]);
    return (prevDate != null && DateUtils.isSameDay(date, prevDate))
        ? const SizedBox(height: 15)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 17),
            child: dividerHeading(dateToFormattedString(date)),
          );
  }
}
