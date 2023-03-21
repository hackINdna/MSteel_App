import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';

class StockStatementScreen extends StatefulWidget {
  const StockStatementScreen({super.key});
  static const routeName = "/stockStatements";

  @override
  State<StockStatementScreen> createState() => _StockStatementScreenState();
}

class _StockStatementScreenState extends State<StockStatementScreen> {
  var pipeDetailsList = getpipeDetails();

  AuthService authService = AuthService();
  List<dynamic> stockList = [];
  bool isLoading = true;
  void getStocks() async {
    stockList = await authService.getAllStock(context: context);
    print("stockList => $stockList");
    setState(() {
      isLoading = false;
    });
  }

  List<DataColumn> col = [];
  List<DataCell> cellss = [];

  @override
  void initState() {
    getStocks();
    super.initState();
  }

  bool permissionGranted = false;

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        permissionGranted = false;
      });
    }
  }

  Future<void> exportToExcel(List<dynamic> rowsData, String stockName) async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];

    for (var row = 0; row < rowsData.length; row++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
          .value = rowsData[row]["value"];
    }

    var fileBytes = excel.save();
    var date = DateTime.now().millisecondsSinceEpoch;

    final PermissionStatus permissionStatus =
        await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      // Permission granted, you can now save the file
      File newPDF =
          await File("/storage/emulated/0/Download/msteel--excel-$date.xlsx")
              .create();
      await newPDF.writeAsBytes(fileBytes!);
    } else {
      // Permission not granted, handle accordingly
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // var user = Provider.of<UserProvider>(context).user;
    // print(stockList;

    // var searchController = TextEditingController();
    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : RootColumn(
            screenPadding: const EdgeInsets.symmetric(vertical: 20),
            heading: transText(context).stockStatements,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 21),
              //   child: SearchTextField(
              //       onChanged: (val) {
              //         print("typed: $val");
              //       },
              //       controller: searchController),
              // ),
              const SizedBox(height: 26),
              // const Center(
              //     child:
              //         BiggerBoxHeadingText(text: "Trimurti Re-Rollers Pipe Stock")),
              // Padding(
              //   padding: const EdgeInsets.only(left: 21, top: 15),
              //   child: BiggerBoxHeadingText(
              //       text:
              //           "Date: ${stringDateToFormattedString(DateTime.now().toString())}"),
              // ),
              const SizedBox(height: 26),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: stockList.length,
                itemBuilder: (context, index) {
                  // return Row(
                  //   children: [
                  //     Text(stockList[index]["value"].toString()),
                  //   ],
                  // );
                  // col = [];
                  // cellss = [];
                  // for (var i = 0;
                  //     i < stockList[index]["stockData"]["fields"].length;
                  //     i++) {
                  //   var ab = stockList[index]["stockData"]["fields"][i];
                  //   col.add(DataColumn(label: Text(ab)));
                  // }
                  // for (var i = 0;
                  //     i < stockList[index]["stockData"]["fields"].length;
                  //     i++) {
                  //   var abb = stockList[index]["stockData"]["allData"];
                  //   var qName = stockList[index]["stockData"]["fields"][i];
                  //   cellss.add(DataCell(Text(abb["$qName"].toString())));
                  // }

                  return Column(
                    children: [
                      Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.05,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: screenSize.width * 0.02),
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${stockList[index]["stockName"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  showCircularProgressIndicator(
                                      context: context);
                                  await exportToExcel(
                                      stockList[index]["excelData"],
                                      stockList[index]["stockName"]);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.download))
                          ],
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.02),
                        child: Column(
                          children:
                              stockList[index]["excelData"].map<Widget>((data) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data["value"],
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        // child: DataTable(
                        //   columns: col,
                        //   rows: [
                        //     DataRow(
                        //       cells: cellss,
                        //     ),
                        //   ],
                        // ),
                      ),
                    ],
                  );
                },
              )
              // ListView.builder(
              //   primary: false,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) => PipeDataWidget(
              //     pipeSize: pipeDetailsList[index].pipeSize,
              //     pipeName: pipeDetailsList[index].pipeName,
              //     fields: pipeDetailsList[index].fields,
              //   ),
              //   itemCount: pipeDetailsList.length,
              // )
            ],
          );
  }
}
