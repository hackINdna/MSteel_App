import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/congratulations_dialog.dart';
import 'package:m_steel/widgets/item_box.dart';
import 'package:m_steel/widgets/place_order_dialog.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.itemDetails});
  static const routeName = "/placeOrder";
  final ItemData itemDetails;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late ItemData itemDetails;
  @override
  void initState() {
    super.initState();
    itemDetails = widget.itemDetails;
  }

  @override
  Widget build(BuildContext context) {
    return RootColumn(heading: null, children: [
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => itemBoxBuilder(context, index),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: itemDetails.items.length)
    ]);
  }

  Widget itemBoxBuilder(BuildContext context, int index) {
    var item = itemDetails.items;
    var price = item.values.elementAt(index);
    var size = item.keys.elementAt(index);
    return ItemWidget(
        item: size,
        suffix: itemDetails.itemSuffix,
        onItemPressed: () => onClick(index),
        amount: price);
  }

  void onClick(int index) async {
    var item = itemDetails.items;
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PlaceOrderDialog(itemDetails: itemDetails);
        });
  }
}
