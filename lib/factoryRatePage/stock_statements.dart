import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';
import 'package:m_steel/widgets/pipe_data_box.dart';
import 'package:m_steel/widgets/search_box.dart';
import 'package:provider/provider.dart';

class StockStatementScreen extends StatefulWidget {
  const StockStatementScreen({super.key});
  static const routeName = "/stockStatements";

  @override
  State<StockStatementScreen> createState() => _StockStatementScreenState();
}

class _StockStatementScreenState extends State<StockStatementScreen> {
  var pipeDetailsList = getpipeDetails();

  AuthService authService = AuthService();
  List<Map<String, String>> stockList = [];
  bool isLoading = true;
  void getStocks() async {
    await authService.getAllStock(context: context);
    setState(() {
      isLoading = false;
    });
  }

  List<DataColumn> col = [];
  List<DataCell> cellss = [];

  // @override
  // void initState() {
  //   getStocks();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    print(user.stock);

    // var searchController = TextEditingController();
    return
        // isLoading
        //     ? const Scaffold(
        //         body: Center(child: CircularProgressIndicator()),
        //       )
        //     :
        RootColumn(
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
          itemCount: user.stock!.length,
          itemBuilder: (context, index) {
            col = [];
            cellss = [];
            for (var i = 0;
                i < user.stock![index]["stockData"]["fields"].length;
                i++) {
              var ab = user.stock![index]["stockData"]["fields"][i];
              col.add(DataColumn(label: Text(ab)));
            }
            for (var i = 0;
                i < user.stock![index]["stockData"]["fields"].length;
                i++) {
              var abb = user.stock![index]["stockData"]["allData"];
              var qName = user.stock![index]["stockData"]["fields"][i];
              cellss.add(DataCell(Text(abb["$qName"].toString())));
            }

            return Column(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.05,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: screenSize.width * 0.02),
                  color: Colors.blue,
                  child: Text(
                    "${user.stock![index]["stateName"]} - ${user.stock![index]["stockName"]} - ${user.stock![index]["stockData"]["thickness"]}mm",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: DataTable(
                      columns: col,
                      rows: [
                        DataRow(
                          cells: cellss,
                        ),
                      ],
                    ),
                  ),
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
