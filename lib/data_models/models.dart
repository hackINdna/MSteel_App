import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

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

class PipeSpecs {
  final String thickness;
  final String wpp;
  final double? qty1;
  final double? qty2;
  final double? qty3;
  PipeSpecs({
    required this.thickness,
    required this.wpp,
    this.qty1,
    this.qty2,
    this.qty3,
  });

  PipeSpecs copyWith({
    String? thickness,
    String? wpp,
    double? qty1,
    double? qty2,
    double? qty3,
  }) {
    return PipeSpecs(
      thickness: thickness ?? this.thickness,
      wpp: wpp ?? this.wpp,
      qty1: qty1 ?? this.qty1,
      qty2: qty2 ?? this.qty2,
      qty3: qty3 ?? this.qty3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thickness': thickness,
      'wpp': wpp,
      'qty1': qty1,
      'qty2': qty2,
      'qty3': qty3,
    };
  }
}

class PipeDetails {
  final String pipeSize;
  final String pipeName;
  final List<Map<String, dynamic>> fields;
  // final List<PipeSpecs> specs;
  PipeDetails({
    required this.pipeSize,
    required this.pipeName,
    required this.fields,
  });

  PipeDetails copyWith({
    String? pipeSize,
    String? pipeName,
    List<Map<String, dynamic>>? fields,
  }) {
    return PipeDetails(
      pipeSize: pipeSize ?? this.pipeSize,
      pipeName: pipeName ?? this.pipeName,
      fields: fields ?? this.fields,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pipeSize': pipeSize,
      'pipeName': pipeName,
      'fields': fields,
    };
  }

  factory PipeDetails.fromMap(Map<String, dynamic> map) {
    return PipeDetails(
      pipeSize: map['pipeSize'] as String,
      pipeName: map['pipeName'] as String,
      fields: List<Map<String, dynamic>>.from(
        (map['fields'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PipeDetails.fromJson(String source) =>
      PipeDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PipeDetails(pipeSize: $pipeSize, pipeName: $pipeName, fields: $fields)';

  @override
  bool operator ==(covariant PipeDetails other) {
    if (identical(this, other)) return true;

    return other.pipeSize == pipeSize &&
        other.pipeName == pipeName &&
        listEquals(other.fields, fields);
  }

  @override
  int get hashCode => pipeSize.hashCode ^ pipeName.hashCode ^ fields.hashCode;
}

class MapModel {
  String name;
  String disp;
  Color? color;
  MapModel({
    required this.name,
    required this.disp,
    this.color,
  });
}
