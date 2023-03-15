import 'package:flutter/widgets.dart';
import 'package:m_steel/model/stockModel.dart';

class StockProvider extends ChangeNotifier {
  var _stock = StockModel(
    id: "",
    stateName: "",
    stockName: "",
    businessType: "",
    stockDate: "",
    stockPrice: 0.00,
    stockData: "",
  );

  StockModel get stock => _stock;

  void setStock(String source) {
    _stock = StockModel.fromJson(source);

    notifyListeners();
  }
}
