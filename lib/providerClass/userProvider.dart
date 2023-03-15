import 'package:flutter/widgets.dart';
import 'package:m_steel/model/userModel.dart';

class UserProvider extends ChangeNotifier {
  var _user = UserModel(
    id: "",
    fullName: "",
    address: "",
    profilePic: "",
    number: "",
    email: "",
    zipCode: "",
    city: "",
    state: "",
    businessType: "",
    balanceAmount: "",
    subscribed: false,
    bills: [],
    enquiry: [],
    orders: [],
    receipts: [],
    transactions: [],
  );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);

    notifyListeners();
  }
}
