import 'package:flutter/material.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/place_order.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/state_rate_box.dart';

class StateRatesScreen extends StatefulWidget {
  const StateRatesScreen({super.key});
  static const routeName = "/stateRates";
  @override
  State<StateRatesScreen> createState() => _StateRatesScreenState();
}

class _StateRatesScreenState extends State<StateRatesScreen> {
  var stateItems = getStateItems();
  @override
  Widget build(BuildContext context) {
    return RootColumn(heading: null, children: [
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => categoryBoxBuilder(context, index),
        itemCount: stateItems.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      )
    ]);
  }

  categoryBoxBuilder(BuildContext context, int index) {
    var item = stateItems[index];
    return StateRateWidget(
      categoryName: item.categoryName,
      categorySubtitle: item.categorySubtitle,
      date: item.date,
      amount: item.amount,
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
