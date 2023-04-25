import 'package:flutter/material.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/orderAndBillPage/place_order.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/state_rate_box.dart';

class StateRatesScreen extends StatefulWidget {
  const StateRatesScreen({super.key, required this.stateName});
  static const routeName = "/stateRates";
  final String stateName;
  @override
  State<StateRatesScreen> createState() => _StateRatesScreenState();
}

class _StateRatesScreenState extends State<StateRatesScreen> {
  var stateItems = getStateItems();
  AuthService authService = AuthService();
  bool isLoading = true;
  List<dynamic>? stockList;

  Future<void> getStock() async {
    stockList = await authService.getStockList(
        context: context, stateName: widget.stateName);
    setState(() {});
  }

  @override
  void initState() {
    getStock();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return stockList == null
        ? Scaffold(
            appBar: generalAppbar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : stockList!.isEmpty
            ? Scaffold(
                appBar: generalAppbar(),
                body: const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                  ),
                ))
            : RootColumn(heading: null, children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      categoryBoxBuilder(context, index),
                  itemCount: stockList!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                )
              ]);
  }

  categoryBoxBuilder(BuildContext context, int index) {
    var item = stockList![index];

    return StateRateWidget(
      categoryName: item["stockName"],
      categorySubtitle: "Ex-${item['stateName']}",
      date: DateTime.parse(item['stockDate']).toString(),
      amount: item["basic"].toString(),
      onCategoryPressed: () {
        // Navigator.pushNamed(context, PlaceOrderScreen.routeName,
        //     arguments: item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceOrderScreen(itemDetails: item),
          ),
        );
      },
    );
  }
}
