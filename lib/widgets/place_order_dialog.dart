import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/make_payment.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/congratulations_dialog.dart';
import 'box_text_widgets.dart';

class PlaceOrderDialog extends StatefulWidget {
  const PlaceOrderDialog({
    Key? key,
    required this.itemDetails,
  }) : super(key: key);
  final ItemData itemDetails;

  @override
  State<PlaceOrderDialog> createState() => _PlaceOrderDialogState();
}

class _PlaceOrderDialogState extends State<PlaceOrderDialog> {
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

  void placeOrder() {
    var quant = int.tryParse(quantityController.text);
    if (quant != null && quant > 0 && quantityError == null) {
      Navigator.of(context).pop();
      //this will be shown when MakePayment screen will set payment true..
      showDialog(
        context: context,
        builder: (context) => const CongratulationsDialog(),
      );

      //perform order process
      Navigator.of(context).pushNamed(MakePaymentScreen.routeName);
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
                                  widget.itemDetails.categoryName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${widget.itemDetails.categorySubtitle}-${stringDateToFormattedString(widget.itemDetails.date)}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.9,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "INR ${widget.itemDetails.amount}",
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
                              OffBlackText(widget.itemDetails.amount)
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
                                  ? (buyQuantity! *
                                          int.parse(widget.itemDetails.amount))
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
