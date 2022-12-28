import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';

class OrderDetailsWidget extends StatelessWidget {
  final String orderNumber, company, quantity, balanceQuantity, bookingRate;
  //use OrderStatus class to provide StatusContent
  final StatusContent status;
  final void Function()? onTap;
  const OrderDetailsWidget({
    super.key,
    required this.orderNumber,
    required this.bookingRate,
    required this.quantity,
    required this.company,
    required this.balanceQuantity,
    required this.status,
    this.onTap,
  });

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
        child: InkWell(
          onTap: () => onTap?.call(),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BoxHeadingText("${transText(context).order} #$orderNumber"),
                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 11.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: screenSize.width * 0.21,
                        child: BoxGrayText(
                            "${transText(context).quantity}: $quantity")),
                    Container(
                        alignment: Alignment.center,
                        width: screenSize.width * 0.27,
                        child: BoxGrayText("Balance Qty: $balanceQuantity")),
                    Container(
                      alignment: Alignment.topRight,
                      width: screenSize.width * 0.37,
                      child: BoxGrayText(
                          "${transText(context).bookingRate}: $bookingRate"),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                status.textWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
