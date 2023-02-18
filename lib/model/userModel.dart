import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String fullName;
  final String number;
  final String email;
  final String zipCode;
  final String city;
  final String state;
  final String businessType;
  List<dynamic>? enquiry;
  List<dynamic>? orders;
  List<dynamic>? transactions;
  List<dynamic>? receipts;
  List<dynamic>? bills;
  UserModel({
    required this.id,
    required this.fullName,
    required this.number,
    required this.email,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.businessType,
    this.enquiry,
    this.orders,
    this.transactions,
    this.receipts,
    this.bills,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'number': number,
      'email': email,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'businessType': businessType,
      'enquiry': enquiry,
      'orders': orders,
      'transactions': transactions,
      'receipts': receipts,
      'bills': bills,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      fullName: map['fullName'] as String,
      number: map['number'] as String,
      email: map['email'] as String,
      zipCode: map['zipCode'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      businessType: map['businessType'] as String,
      enquiry: map['enquiry'] != null
          ? List<dynamic>.from((map['enquiry'] as List<dynamic>))
          : null,
      orders: map['orders'] != null
          ? List<dynamic>.from((map['orders'] as List<dynamic>))
          : null,
      transactions: map['transactions'] != null
          ? List<dynamic>.from((map['transactions'] as List<dynamic>))
          : null,
      receipts: map['receipts'] != null
          ? List<dynamic>.from((map['receipts'] as List<dynamic>))
          : null,
      bills: map['bills'] != null
          ? List<dynamic>.from((map['bills'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
