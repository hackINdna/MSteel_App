//sample order statements list
import 'package:flutter/cupertino.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/util/general.dart';

List<OrderStatementData> getSampleOrderStatementsNEW(BuildContext context) {
  return [
    OrderStatementData(
        orderNumber: "MS/47/19-20",
        quantity: "15",
        status: OrderStatus.of(context).pending,
        bookingRate: "27700"),
    OrderStatementData(
        orderNumber: "MS/47/19-20",
        quantity: "15",
        status: OrderStatus.of(context).shippingInProcess,
        bookingRate: "27700"),
  ];
}

List<OrderStatementData> getSampleOrderStatementsOLD(BuildContext context) {
  return [
    OrderStatementData(
        orderNumber: "MS/47/19-20",
        quantity: "15",
        status: OrderStatus.of(context).approved,
        bookingRate: "27700"),
  ];
}
