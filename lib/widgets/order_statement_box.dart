import 'package:flutter/material.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';

import '../util/general.dart';

class OrderStatementWidget extends StatelessWidget {
  final String orderNumber, bookingRate, quantity;
  //use OrderStatus class to provide StatusContent
  final StatusContent status;
  final void Function()? onTap;
  const OrderStatementWidget({
    super.key,
    required this.orderNumber,
    required this.quantity,
    required this.bookingRate,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Material(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3.5), topRight: Radius.circular(3.5)),
        color: Colors.white,
        child: InkWell(
          onTap: () => onTap?.call(),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BoxHeadingText("${transText(context).order}: #$orderNumber"),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoxGrayText("${transText(context).quantity}: $quantity"),
                    BoxGrayText(
                        "${transText(context).bookingRate}: $bookingRate"),
                  ],
                ),
                const SizedBox(height: 11),
                status.textWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Layout using ClipRRect
// Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5.1),
//                   border: Border.all(width: 1.7, color: BoxColors.border),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromARGB(255, 158, 158, 158), //New
//                       blurRadius: 3.0,
//                       spreadRadius: -2,
//                       offset: Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 //surfaceTintColor: ,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(3),
//                   child: Container(
//                     height: 100,
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         bottom:
//                             BorderSide(width: 3.5, color: BoxColors.approved),
//                       ),
//                       color: Colors.white,
//                     ),
//                     child: const Center(child: Text("Content")),
//                   ),
//                 ),
//               ),
