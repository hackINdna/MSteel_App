import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

import 'box_text_widgets.dart';

class BillWidget extends StatelessWidget {
  final String billNumber, amount, billDownloadLink;
  final StatusContent status;

  const BillWidget({
    super.key,
    required this.billNumber,
    required this.amount,
    required this.billDownloadLink,
    required this.status,
  });
  bool downloadBill(String url) {
    return true;
  }

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
              const BoxHeadingText("MSteel"),
              Text(
                "${transText(context).bill} #$billNumber",
                style: const TextStyle(
                  fontSize: 11.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BoxGrayText("INR $amount"),
                  SizedBox(
                    height: 35,
                    width: 44,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          downloadBill(billDownloadLink)
                              ? showSnackBar(
                                  context, "Bill Downloaded Successfully.")
                              : showSnackBar(context, "Bill Download Failed.");
                        },
                        icon: const Icon(
                          Icons.download,
                          color: appBlueBg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              status.textWidget,
            ],
          ),
        ),
      ),
    );
  }
}
