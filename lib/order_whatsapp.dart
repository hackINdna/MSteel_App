import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/widgets/basic_root_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceOrderWhatsappScreen extends StatelessWidget {
  const PlaceOrderWhatsappScreen({super.key});
  static const routeName = "/orderOnWhatsapp";
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var item = args['itemData'] as ItemData;
    var size = args['size'] as String;
    var quantity = args['quantity'] as String;

    return RootColumn(
      heading: "Order Summary",
      children: [
        dividerHeading("Item Details:"),
        const SizedBox(height: 30),
        rowItem("Item:",
            "${item.categoryName}, ${item.categorySubtitle}-(${item.itemSuffix})"),
        const SizedBox(height: 9),
        rowItem("Size: ", size),
        const SizedBox(height: 9),
        rowItem("Quantity: ", quantity),
        const SizedBox(height: 9),
        rowItem("Price: ", item.amount),
        const SizedBox(height: 9),
        rowItem(
          "Amount Payable: ",
          "INR ${int.parse(item.amount) * int.parse(quantity)}",
        ),
        SizedBox(height: screenSize.height * 0.052), //0.45 for bottom
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: appBlueBg2,
                fixedSize: const Size.fromHeight(44)),
            onPressed: () async {
              String text =
                  "Hello _Admin_,\nI am intrested in buying:\n*Item:* ${item.categoryName} ${item.categorySubtitle} (${item.itemSuffix}),\n*Size:* $size,\n *Amount:* ${item.amount},\n*Quantity:* $quantity";
              // var link = WhatsAppUnilink(
              //   phoneNumber: "+919460089701",
              //   text: text,
              // );

              var link = "https://wa.me/8696888148?text=$text";
              if (await canLaunchUrl(Uri.parse(link))) {
                await launchUrl(Uri.parse(link),
                    mode: LaunchMode.externalApplication);
              } else {
                showSnackBar(context, "Cannot Launch Whatsapp");
              }
            },
            icon: const Icon(Icons.whatsapp),
            label: const Text("Place Order on Whatsapp"))
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
            content,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
