import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';

class StateRateWidget extends StatelessWidget {
  final String categoryName, categorySubtitle, date, amount;
  final void Function() onCategoryPressed;
  const StateRateWidget({
    super.key,
    required this.categoryName,
    required this.categorySubtitle,
    required this.date,
    required this.amount,
    required this.onCategoryPressed,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenSize.width * 0.5,
            //COLUMN 1
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BiggerBoxHeadingText(text: categoryName),
                // BiggerGrayText(
                //     text:
                //         "$categorySubtitle-${stringDateToFormattedString(date)}"),
                BoxGrayText(
                    "$categorySubtitle-${stringDateToFormattedString(date)}"),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 8),
              SmallerBoxText("INR $amount"),
              const SizedBox(height: 12),
              SizedBox(
                height: 30.3,
                child: OutlinedButton(
                  onPressed: onCategoryPressed,
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
            ],
          ),
        ],
      ),
    );
  }
}
