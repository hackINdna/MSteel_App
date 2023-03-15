import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m_steel/auth/auth_service.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/data_models/sample_data.dart';
import 'package:m_steel/homePage/home.dart';
import 'package:m_steel/providerClass/userProvider.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaceOrderWhatsappScreen extends StatelessWidget {
  PlaceOrderWhatsappScreen({super.key});
  static const routeName = "/orderOnWhatsapp";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var item = args['itemData'] as dynamic;
    var itemStock = args['itemStock'] as dynamic;

    var stockPrice = double.parse(item["basic"]) +
        double.parse(item["loading"]) +
        double.parse(item["insurance"]) +
        double.parse(item["gst"]) +
        double.parse(item["tcs"]);
    var size = args['size'] as String;
    var quantity = args['quantity'] as String;

    return RootColumn(
      heading: "Order Summary",
      children: [
        dividerHeading("Item Details:"),
        const SizedBox(height: 30),
        rowItem("Item:",
            "${itemStock["stockName"]}, ${itemStock["stateName"]}-(TP)"),
        const SizedBox(height: 9),
        rowItem("Size: ", "${size}mm"),
        const SizedBox(height: 9),
        rowItem("Quantity: ", quantity),
        const SizedBox(height: 9),
        rowItem("Price: ", stockPrice),
        const SizedBox(height: 9),
        rowItem(
          "Amount Payable: ",
          "INR ${stockPrice * int.parse(quantity)}",
        ),
        SizedBox(height: screenSize.height * 0.052), //0.45 for bottom
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: appBlueBg2,
                fixedSize: const Size.fromHeight(44)),
            onPressed: user.subscribed
                ? () async {
                    String text =
                        "Hello _Admin_,\nI am intrested in buying:\n*Item:* ${itemStock["stockName"]} - ${itemStock["stateName"]} (TP),\n*Size:* ${size}mm,\n *Amount:* INR $stockPrice,\n*Quantity:* $quantity";
                    // var link = WhatsAppUnilink(
                    //   phoneNumber: "+919460089701",
                    //   text: text,
                    // );

                    var link = "https://wa.me/9024350276?text=$text";
                    // var link = "https://api.whatsapp.com/send?phone=919024350276";
                    if (await canLaunchUrl(Uri.parse(link))) {
                      navigatorPush() => Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                      showCircularProgressIndicator(context: context);
                      await authService.sendOrder(
                        context: context,
                        date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        time: DateFormat("kk:mm").format(DateTime.now()),
                        fullName: user.fullName,
                        number: user.number,
                        state: itemStock["stateName"],
                        netPrice: stockPrice,
                        orderQuantity: int.parse(quantity),
                        orderAmount: (stockPrice * int.parse(quantity)),
                        stockId: itemStock["_id"],
                      );
                      await launchUrl(Uri.parse(link),
                          mode: LaunchMode.externalApplication);
                      navigatorPush();
                    } else {
                      showSnackBar(context, "Cannot Launch Whatsapp");
                    }
                  }
                : null,
            // icon: const Icon(Icons.whatsapp),
            icon: const FaIcon(FontAwesomeIcons.whatsapp),
            label: const Text("Place Order on Whatsapp")),
        user.subscribed
            ? Container()
            : Container(
                width: screenSize.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "*Buy Subscription plan to place order.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.red[400]),
                ),
              ),
      ],
    );
  }

  Padding rowItem(String title, content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          Text(
            content.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
