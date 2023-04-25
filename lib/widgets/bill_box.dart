import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import 'box_text_widgets.dart';

class BillWidget extends StatelessWidget {
  final String quantity, amount, billDownloadLink;
  final StatusContent status;
  final dynamic content;

  const BillWidget({
    super.key,
    required this.quantity,
    required this.amount,
    required this.billDownloadLink,
    required this.content,
    required this.status,
  });
  bool downloadBill(String url) {
    return true;
  }

  Future<void> generatePDF() async {
    // Create a new PDF document.
    final pdf = pw.Document();

    // Add content to the PDF.
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Date: ${content["billDate"]}'),
              pw.Text('Order Number: ${content["orderNumber"]}'),
              pw.Text('Name: ${content["fullName"]}'),
              pw.Text('Product Name: ${content["productName"]}'),
              pw.Text('Order Quantity: ${content["orderQuantity"]}'),
              pw.Text('Total Amount: ${content["totalAmount"]}'),
            ],
          ),
        ),
      ),
    );

    // Get the path to the Downloads folder.
    // final downloadsDirectory = await getExternalStorageDirectory();
    var date = DateTime.now().millisecondsSinceEpoch;
    final PermissionStatus permissionStatus =
        await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      final downloadFilePath =
          '/storage/emulated/0/Download/msteel-bill-pdf$date.pdf';

      // Save the PDF to the Downloads folder.
      final file = File(downloadFilePath);
      await file.writeAsBytes(await pdf.save());

      // Show a message to the user that the PDF has been saved.
      print('PDF saved to: $downloadFilePath');
    }
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
            topLeft: Radius.circular(3.5),
            topRight: Radius.circular(3.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BoxHeadingText("MSteel"),
              Text(
                "${transText(context).quantity}: $quantity",
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
                        onPressed: () async {
                          showCircularProgressIndicator(context: context);
                          navigatorPop() => Navigator.pop(context);
                          await generatePDF();
                          navigatorPop();
                          showSnackBar(context, "Bill Downloaded");
                          // downloadBill(billDownloadLink)
                          //     ? showSnackBar(
                          //         context, "Bill Downloaded Successfully.")
                          //     : showSnackBar(context, "Bill Download Failed.");
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
