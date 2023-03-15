// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

class StockModel {
  final String id;
  final String stateName;
  final String stockName;
  final String businessType;
  final String stockDate;
  final double stockPrice;
  final dynamic stockData;
  StockModel({
    required this.id,
    required this.stateName,
    required this.stockName,
    required this.businessType,
    required this.stockDate,
    required this.stockPrice,
    required this.stockData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stateName': stateName,
      'stockName': stockName,
      'businessType': businessType,
      'stockDate': stockDate,
      'stockPrice': stockPrice,
      'stockData': stockData,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['_id'] as String,
      stateName: map['stateName'] as String,
      stockName: map['stockName'] as String,
      businessType: map['businessType'] as String,
      stockDate: map['stockDate'] as String,
      stockPrice: map['stockPrice'] as double,
      stockData: map['stockData'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
