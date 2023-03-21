import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/orderAndBillPage/order_whatsapp.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'box_text_widgets.dart';

class PlaceOrderDialog extends StatefulWidget {
  const PlaceOrderDialog({
    Key? key,
    required this.itemStock,
    required this.itemData,
    required this.size,
  }) : super(key: key);
  final dynamic itemStock;
  final dynamic itemData;
  final String size;

  @override
  State<PlaceOrderDialog> createState() => _PlaceOrderDialogState();
}

class _PlaceOrderDialogState extends State<PlaceOrderDialog> {
  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }

  int? buyQuantity;
  String? quantityError;
  TextEditingController quantityController = TextEditingController();
  void updateQuantity(int? quantity) {
    setState(() {
      if (quantity == null || quantity <= 0) {
        quantityError = "Enter a valid quantity.";
        return;
      } else {
        quantityError = null;
      }
      buyQuantity = quantity;
    });
  }

  Future<void> placeOrder() async {
    var quant = int.tryParse(quantityController.text);
    if (quant != null && quant > 0 && quantityError == null) {
      var item = widget.itemData;
      print("item => $item");
      var size = widget.size;
      print("size => $size");
      Navigator.of(context)
          .popAndPushNamed(PlaceOrderWhatsappScreen.routeName, arguments: {
        "itemData": item,
        "itemStock": widget.itemStock,
        "size": size,
        "quantity": quantityController.text.toString(),
      });
      //this will be shown when MakePayment screen will set payment true..
      // showDialog(
      //   context: context,
      //   builder: (context) => const CongratulationsDialog(),
      // );

      //perform order process
      // Navigator.of(context).pushNamed(MakePaymentScreen.routeName);
    } else {
      setState(() {
        quantityError = "Enter a valid quantity.";
      });
    }
  }

  OutlineInputBorder genBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(color: appBlueBg),
  );
  @override
  Widget build(BuildContext context) {
    var dialogSize = MediaQuery.of(context).size;
    print("item stock => ${widget.itemStock}");
    print("item Data => ${widget.itemData}");
    var stockPrice =
        widget.itemStock["basic"] + double.parse(widget.itemData["amount"]);
    // widget.itemStock["loading"] +
    // widget.itemStock["insurance"] +
    // widget.itemStock["gst"] +
    // widget.itemStock["tcs"];

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: dialogSize.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: dialogSize.width * 0.065),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: dialogSize.height * 0.015),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12.5),
                      decoration: const BoxDecoration(
                        color: appBlueBg,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: dialogSize.width * 0.51,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  widget.itemStock["stockName"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${widget.itemStock["stateName"]}-${widget.itemStock["stockDate"]}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.9,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "INR $stockPrice",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText("${transText(context).netPrice}:"),
                              OffBlackText(stockPrice.toString())
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText("Loading:"),
                              OffBlackText(
                                  widget.itemStock["loading"].toString()),
                              // OffBlackText("${transText(context).netPrice}:"),
                              // OffBlackText(stockPrice.toString())
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText("GST(${widget.itemStock["gst"]}%):"),
                              OffBlackText(
                                  ((stockPrice * widget.itemStock["gst"]) / 100)
                                      .toString()),
                              // OffBlackText("${transText(context).netPrice}:"),
                              // OffBlackText(stockPrice.toString())
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText("TCS:"),
                              OffBlackText(widget.itemStock["tcs"].toString()),
                              // OffBlackText("${transText(context).netPrice}:"),
                              // OffBlackText(stockPrice.toString())
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText("Insurance:"),
                              OffBlackText(
                                  widget.itemStock["insurance"].toString()),
                              // OffBlackText("${transText(context).netPrice}:"),
                              // OffBlackText(stockPrice.toString())
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText(
                                  "${transText(context).orderQuantity}:"),
                              OffBlackText((buyQuantity != null)
                                  ? buyQuantity.toString()
                                  : ""),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OffBlackText(
                                  "${transText(context).orderAmount}:"),
                              OffBlackText((buyQuantity != null)
                                  ? ((buyQuantity! *
                                              double.parse(
                                                  stockPrice.toString())) +
                                          (((buyQuantity! *
                                                      double.parse(stockPrice
                                                          .toString())) *
                                                  widget.itemStock["gst"]) /
                                              100))
                                      .toString()
                                  : ""),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.9),
                            controller: quantityController,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              updateQuantity(int.tryParse(value));
                            },
                            decoration: InputDecoration(
                              errorText: quantityError,
                              isCollapsed: true,
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.9),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              focusedBorder: genBorder,
                              border: genBorder,
                              enabledBorder: genBorder,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              hintText: transText(context).enterQuantityinMT,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 32.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side:
                                            const BorderSide(color: appBlueBg)),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      transText(context).cancel,
                                      style: const TextStyle(fontSize: 12),
                                    )),
                                ElevatedButton(
                                    onPressed: placeOrder,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: appBlueBg2),
                                    child: Text(
                                      transText(context).placeOrder,
                                      style: const TextStyle(fontSize: 12.9),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: dialogSize.width * 0.065 / 2,
                top: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Color(0xffD12121),
                    child: Icon(Icons.close, color: Colors.white, size: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
