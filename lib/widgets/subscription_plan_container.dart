// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class SubscriptionPlanBox extends StatelessWidget {
  final String months, price;
  final String? header;
  final bool isSelected;
  const SubscriptionPlanBox({
    Key? key,
    required this.price,
    this.header,
    required this.months,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color getColor({bool opposite = false}) =>
        (opposite ? !isSelected : isSelected) ? Colors.white : subscriptionGray;
    Color borderColor({bool opposite = false}) =>
        (opposite ? !isSelected : isSelected) ? Colors.white : Colors.black;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: EdgeInsets.only(top: screenSize.height * 0.015),
          decoration: BoxDecoration(
              border: Border.all(
            color: borderColor(),
            width: isSelected ? 2.4 : 1,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(months,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: getColor())),
              Text(
                transText(context).months,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: getColor()),
              ),
              const SizedBox(height: 21),
              Text(
                "INR $price/${transText(context).months.substring(0, 2)}",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: getColor()),
              )
            ],
          ),
        ),
        (header != null)
            ? Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(header!),
                padding: EdgeInsets.zero,
                backgroundColor: borderColor(),
                visualDensity:
                    const VisualDensity(horizontal: 0.0, vertical: -4),
                labelStyle: TextStyle(
                  fontSize: 11,
                  color: borderColor(opposite: true),
                  fontWeight: FontWeight.w500,
                ),
              )
            : const SizedBox(height: 0),
      ],
    );
  }
}
