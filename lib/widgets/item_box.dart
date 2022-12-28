import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';

class ItemWidget extends StatelessWidget {
  final String item, suffix, amount;
  final void Function() onItemPressed;

  const ItemWidget({
    super.key,
    required this.item,
    required this.onItemPressed,
    required this.amount,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoxHeadingText(item),
              BoxHeadingText("INR $amount($suffix)")
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 30.3,
              child: OutlinedButton(
                onPressed: onItemPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: appBlueBg,
                  side: const BorderSide(color: appBlueBg),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: Text(
                  transText(context).orderNow,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
