import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:m_steel/widgets/congratulations_dialog.dart';
import 'package:m_steel/widgets/item_box.dart';
import 'package:m_steel/widgets/place_order_dialog.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.itemDetails});
  static const routeName = "/placeOrder";
  final dynamic itemDetails;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late dynamic itemDetails;
  @override
  void initState() {
    super.initState();
    itemDetails = widget.itemDetails;
  }

  @override
  Widget build(BuildContext context) {
    print("stock => $itemDetails");
    return RootColumn(heading: null, children: [
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => itemBoxBuilder(context, index),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: itemDetails["sizes"].length),
    ]);
  }

  Widget itemBoxBuilder(BuildContext context, int index) {
    var item = itemDetails["sizes"][index];
    var price = itemDetails["basic"] + double.parse(item["amount"]);

    print("price -> $price");
    // var price = (int.parse(item["basic"]) +
    //     int.parse(item["loading"]) +
    //     int.parse(item["insurance"]) +
    //     ((int.parse(item["basic"]) * int.parse(item["gst"])) / 100) +
    //     int.parse(item["tcs"]));
    var size = item["size"];
    return ItemWidget(
      item: "${size}mm",
      suffix: "TP",
      onItemPressed: () => onClick(
        index,
      ),
      amount: price.toString(),
    );
  }

  void onClick(int index) async {
    var item = itemDetails["sizes"][index];
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PlaceOrderDialog(
            itemStock: itemDetails,
            itemData: item,
            size: item["size"],
          );
        });
  }
}
