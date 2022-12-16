import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';

class ReceiptWidget extends StatelessWidget {
  final String orderNumber,
      billNumber,
      company,
      quantity,
      balanceQuantity,
      bookingRate,
      amount,
      billDownloadLink;
  final StatusContent status;
  const ReceiptWidget(
      {super.key,
      required this.orderNumber,
      required this.billNumber,
      required this.company,
      required this.quantity,
      required this.balanceQuantity,
      required this.bookingRate,
      required this.amount,
      required this.billDownloadLink,
      required this.status});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(bottom: 3.5),
      decoration: BoxDecoration(
        color: status.color,
        border: Border.all(width: 1.7, color: BoxColors.border),
        borderRadius: BorderRadius.circular(5.1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 158, 158, 158), //New
            blurRadius: 3.0,
            spreadRadius: -2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3.5), topRight: Radius.circular(3.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const BoxHeadingText("MSteel"),
                        Text(
                          company,
                          style: const TextStyle(
                            fontSize: 11.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${transText(context).bill} #$billNumber",
                          style: const TextStyle(
                            fontSize: 11.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.134,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () => showSnackBar(
                            context, "Downloaded Receipt Successfully."),
                        icon: const Icon(Icons.download, color: appBlueBg),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "${transText(context).order} #$orderNumber",
                style: const TextStyle(
                  fontSize: 11.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenSize.width * 0.21,
                      child: BoxGrayTextSmaller(
                          "${transText(context).quantity}: $quantity")),
                  Container(
                      alignment: Alignment.center,
                      width: screenSize.width * 0.27,
                      child:
                          BoxGrayTextSmaller("Balance Qty: $balanceQuantity")),
                  Container(
                    alignment: Alignment.topRight,
                    width: screenSize.width * 0.37,
                    child: BoxGrayTextSmaller(
                        "${transText(context).bookingRate}: $bookingRate"),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "INR $amount",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: BoxColors.grayText,
                ),
              ),
              // const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: status.textWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
