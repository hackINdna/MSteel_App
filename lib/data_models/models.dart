import 'package:m_steel/util/general.dart';

class OrderStatementData {
  String orderNumber, quantity, bookingRate;
  StatusContent status;
  OrderStatementData({
    required this.orderNumber,
    required this.quantity,
    required this.bookingRate,
    required this.status,
  });
}
