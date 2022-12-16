import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// class OrderStatementData {
//   final String orderNumber, quantity, bookingRate, date, status;
//   OrderStatementData(
//     this.orderNumber,
//     this.quantity,
//     this.bookingRate,
//     this.date,
//     this.status,
//   );
// }

class OrderDetailsData {
  final String orderNumber,
      company,
      quantity,
      balanceQuantity,
      bookingRate,
      date,
      status;

  OrderDetailsData(
    this.orderNumber,
    this.company,
    this.quantity,
    this.balanceQuantity,
    this.bookingRate,
    this.date,
    this.status,
  );
  // OrderDetailsData({
  //   required this.orderNumber,
  //   required this.company,
  //   required this.quantity,
  //   required this.balanceQuantity,
  //   required this.bookingRate,
  //   required this.status,
  // });
}

class BillData {
  final String billNumber, amount, date, status, billDownloadLink;

  BillData(
    this.billNumber,
    this.amount,
    this.date,
    this.status,
    this.billDownloadLink,
  );
}

class TransactionData {
  final String bankName, billNumber, amount, balance, date, status;
  final bool debit;

  TransactionData(this.bankName, this.billNumber, this.amount, this.balance,
      this.status, this.date,
      {required this.debit});
}

class ReceiptData {
  final String orderNumber,
      billNumber,
      company,
      quantity,
      balanceQuantity,
      bookingRate,
      date,
      amount,
      billDownloadLink,
      status;

  ReceiptData(
      {required this.orderNumber,
      required this.billNumber,
      required this.company,
      required this.quantity,
      required this.balanceQuantity,
      required this.bookingRate,
      required this.date,
      required this.amount,
      required this.billDownloadLink,
      required this.status});
}

class ItemData {
  final String categoryName, categorySubtitle, itemSuffix, date, amount;
  final Map<String, String> items;

  ItemData({
    required this.categoryName,
    required this.categorySubtitle,
    required this.itemSuffix,
    required this.date,
    required this.amount,
    required this.items,
  });
}

class SubscriptionData {
  final String title;
  final String subtitle;
  final List<SubscriptionPlanVariant> planVariants;
  SubscriptionData({
    required this.title,
    required this.subtitle,
    required this.planVariants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'planVariants': planVariants.map((x) => x.toMap()).toList(),
    };
  }

  factory SubscriptionData.fromMap(Map<String, dynamic> map) {
    return SubscriptionData(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      planVariants: List<SubscriptionPlanVariant>.from(
        (map['planVariants'] as List<int>).map<SubscriptionPlanVariant>(
          (x) => SubscriptionPlanVariant.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionData.fromJson(String source) =>
      SubscriptionData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SubscriptionPlanVariant {
  final String months;
  final String price;
  final String? header;
  SubscriptionPlanVariant({
    required this.months,
    required this.price,
    this.header,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'months': months,
      'price': price,
      'header': header,
    };
  }

  factory SubscriptionPlanVariant.fromMap(Map<String, dynamic> map) {
    return SubscriptionPlanVariant(
      months: map['months'] as String,
      price: map['price'] as String,
      header: map['header'] != null ? map['header'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionPlanVariant.fromJson(String source) =>
      SubscriptionPlanVariant.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
