import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_steel/add_card.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});
  static const routeName = "/makePayment";

  @override
  Widget build(BuildContext context) {
    const boldText = TextStyle(fontWeight: FontWeight.w600);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Container debitCardContainer(double screenHeight, double screenWidth,
        String assetName, String text) {
      return Container(
        height: screenHeight * 0.06,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400, width: 2),
          color: Colors.white,
        ),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
          minLeadingWidth: 30,
          leading: AspectRatio(
              aspectRatio: 0.68, child: SvgPicture.asset(assetName)),
          title: Text(text),
          trailing: Stack(
            children: [
              Container(
                width: screenWidth * 0.04,
                height: screenWidth * 0.04,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RootColumn(heading: "Make Payment", children: [
      // SizedBox(height: screenHeight * 0.008),
      Container(
        width: screenWidth,
        height: screenHeight * 0.32,
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
            const SizedBox(height: 3),
            Divider(
              thickness: 2,
              height: 0.2,
              color: Colors.grey[400],
              indent: screenWidth * 0.02,
              endIndent: screenWidth * 0.02,
            ),
            SizedBox(height: screenHeight * 0.021),
            debitCardContainer(screenHeight, screenWidth,
                "assets/icons/mastercard.svg", "Axis bank ****1234"),
            SizedBox(height: screenHeight * 0.01),
            debitCardContainer(screenHeight, screenWidth,
                "assets/icons/visa.svg", "HDFC bank ****1234"),
            SizedBox(height: screenHeight * 0.024),
            Container(
              width: screenWidth,
              height: screenHeight * 0.06,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.yellow.shade800,
                  width: 2,
                ),
                color: Colors.yellow.shade800.withOpacity(0.5),
              ),
              child: ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -2),
                minLeadingWidth: 30,
                onTap: () {
                  Navigator.of(context).pushNamed(AddCardScreen.routeName);
                },
                leading: const Icon(
                  Icons.add_circle,
                  color: Colors.black,
                ),
                title: const Text(
                  "Add Card",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: screenHeight * 0.03),
      Container(
        // width: screenWidth,
        height: screenHeight * 0.07,
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
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity.standard,
          minLeadingWidth: 30,
          leading: const Icon(
            Icons.account_balance_outlined,
            color: Colors.black54,
            size: 26,
          ),
          title: const Text(
            "Net Banking",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8,
          top: screenHeight * 0.25,
        ),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12),
              backgroundColor: appBlueBg,
              foregroundColor: Colors.white),
          icon: const Icon(Icons.check_circle_outline_rounded),
          label: const Text("Checkout"),
        ),
      ),
    ]);
  }
}
