import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

import 'box_text_widgets.dart';

class TransactionWidget extends StatelessWidget {
  final String bankName, billNumber, amount, balance;
  final StatusContent status;
  final bool debit;
  const TransactionWidget({
    super.key,
    required this.bankName,
    required this.billNumber,
    required this.amount,
    required this.balance,
    required this.debit,
    required this.status,
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
                  BoxHeadingText(bankName),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: debit ? "Dr " : "Cr ",
                        ),
                        TextSpan(
                            text: amount,
                            style: TextStyle(
                              color: debit ? Colors.red : Colors.green,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 3.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoxGrayText("${transText(context).bill} #$billNumber"),
                  BoxGrayText("${transText(context).balance} INR $balance"),
                ],
              ),
              const SizedBox(height: 3.5),
              status.textWidget,
            ],
          ),
        ),
      ),
    );
  }
}
