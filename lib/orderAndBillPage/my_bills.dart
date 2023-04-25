import "package:flutter/material.dart";
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/bill_box.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

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
  List<List<dynamic>>? bbList;
  List<dynamic>? billList;
  List<dynamic>? billPdfList;

  void getAllBills() async {
    bbList = await authService.getAllBills(context: context);
    billList = bbList![0];
    billPdfList = bbList![1];
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllBills();
    super.initState();
  }

  bool showPDF = true;

  void showPDFList(bool val) {
    setState(() {
      showPDF = val;
    });
  }

  Future<void> downloadBillPDF(String imgurl) async {
    try {
      var date = DateTime.now().millisecondsSinceEpoch;
      navigatorPop() => Navigator.pop(context);

      String savePath = "/storage/emulated/0/Download/msteel-bill-$date.pdf";

      await Dio().download(imgurl, savePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
          //you can build progressbar feature too
        }
      });
      showSnackBar(context, "PDF Downloaded");
      navigatorPop();
    } on DioError catch (e) {
      print(e.message);
      showSnackBar(context, "Unable to Download! Try Again");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // billList = getBillData();
    // if (billList.isNotEmpty) {
    //   prevDate = stringToDate(billList.first.date);
    //   print("setting prev date to $prevDate");
    // }
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: generalAppbar(),
      body: bbList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : billList!.isEmpty && billPdfList!.isEmpty
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Uploaded PDF"),
                              Switch(
                                  value: showPDF,
                                  onChanged: (val) => showPDFList(val)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          //condition based heading

                          if (showPDF) ...[
                            const SizedBox(height: 20),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                width: mediaQuery.size.width,
                                height: mediaQuery.size.height * 0.1,
                                padding: EdgeInsets.symmetric(
                                  horizontal: mediaQuery.size.width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(
                                            255, 158, 158, 158), //New
                                        blurRadius: 3.0,
                                        spreadRadius: -2,
                                        offset: Offset(0, 1),
                                      ),
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#Bill-${index + 1}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final PermissionStatus
                                            permissionStatus =
                                            await Permission.storage.request();
                                        print(billPdfList![index].toString());

                                        if (permissionStatus ==
                                            PermissionStatus.granted) {
                                          showCircularProgressIndicator(
                                              context: context);
                                          await downloadBillPDF(
                                              billPdfList![index].toString());
                                        }
                                      },
                                      icon: const Icon(Icons.download),
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.black38,
                                thickness: 1,
                              ),
                              itemCount: billPdfList!.length,
                            ),
                          ] else ...[
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
                          ]
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
