import "package:flutter/material.dart";
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});
  static const routeName = "/addCart";
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final boldText = const TextStyle(fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return RootColumn(
      heading: "Payment",
      children: [
        Container(
          // width: screenWidth,
          height: screenHeight * 0.42,
          // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.058,
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: Container(
                    // color: Colors.amber,
                    margin: const EdgeInsets.only(bottom: 8),
                    width: 39,
                    height: 33,
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Credit/Debit card",
                      style: boldText,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                height: 0.1,
                color: Colors.grey[400],
                indent: screenWidth * 0.02,
                endIndent: screenWidth * 0.02,
              ),
              SizedBox(height: screenHeight * 0.02),
              addCardField(screenWidth, screenHeight, "Cardholder Name",
                  "Enter your name"),
              SizedBox(height: screenHeight * 0.03),
              addCardField(screenWidth, screenHeight, "Card Number",
                  "Enter your card number"),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    smallAddCard(
                        screenWidth, screenHeight, "Expiry Date", "**/**/***"),
                    smallAddCard(screenWidth, screenHeight, "CVV", "***")
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.291),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: appBlueBg,
                foregroundColor: Colors.white),
            icon: const Icon(Icons.add_card),
            label: const Text("Save Card"),
          ),
        ),
      ],
    );
  }

  Padding addCardField(
      double screenWidth, double screenHeight, String text1, String text2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            width: screenWidth * 0.75,
            height: screenHeight * 0.045,
            padding: EdgeInsets.only(
                left: screenWidth * 0.02, top: screenHeight * 0.017),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              ),
              color: Colors.white,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: text2,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: BoxColors.grayText,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget smallAddCard(
      double screenWidth, double screenHeight, String text1, String text2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: screenWidth * 0.30,
          height: screenHeight * 0.045,
          padding: EdgeInsets.only(
              left: screenWidth * 0.02, top: screenHeight * 0.015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: text2,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: BoxColors.grayText,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
