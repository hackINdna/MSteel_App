import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m_steel/common/showCircularProgressIndicator.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/box_text_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ReceiptWidget extends StatelessWidget {
  final String orderNumber,
      // billNumber,
      company,
      quantity,
      // balanceQuantity,
      paidAmount,
      amount,
      billDownloadLink;
  final dynamic content;
  final StatusContent status;
  const ReceiptWidget(
      {super.key,
      required this.orderNumber,
      // required this.billNumber,
      required this.company,
      required this.quantity,
      // required this.balanceQuantity,
      required this.content,
      required this.paidAmount,
      required this.amount,
      required this.billDownloadLink,
      required this.status});

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
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
              pw.Text('Date: ${content["paymentDate"]}'),
              pw.Text('Order Number: ${content["orderNumber"]}'),
              pw.Text('Name: ${content["fullName"]}'),
              pw.Text('Phone number: ${content["number"]}'),
              pw.Text('Product Name: ${content["productName"]}'),
              pw.Text('Net Price: ${content["netPrice"]}'),
              pw.Text('Order Quantity: ${content["orderQuantity"]}'),
              pw.Text('Total Amount: ${content["totalOutstandingPayment"]}'),
              pw.Text('Paid Amount: ${content["totalPaidAmount"]}'),
            ],
          ),
        ),
      ),
    );

    // Get the path to the Downloads folder.
    if (await _requestPermission(Permission.storage)) {
      var downloadsDirectory = await getExternalStorageDirectory();
      // String newPath = "";
      // print(downloadsDirectory);
      // List<String> paths = downloadsDirectory!.path.split("/");
      // for (int x = 1; x < paths.length; x++) {
      //   String folder = paths[x];
      //   if (folder != "Android") {
      //     newPath += "/" + folder;
      //   } else {
      //     break;
      //   }
      // }
      // newPath = "$newPath/MSteel";

      // downloadsDirectory = Directory(newPath);
      // bool hasExisted = await downloadsDirectory.exists();
      // if (!hasExisted) {
      //   downloadsDirectory.create();
      // }
      final downloadFilePath =
          '${downloadsDirectory!.path}/my_pdf_file${DateTime.now()}.pdf';

      // Save the PDF to the Downloads folder.
      final file = File(downloadFilePath);
      await file.writeAsBytes(await pdf.save());

      // Show a message to the user that the PDF has been saved.
      print('PDF saved to: $downloadFilePath');
    } else {
      print("no");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                  SizedBox(
                    width: screenSize.width * 0.66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const BoxHeadingText("MSteel"),
                        Text(
                          company,
                          style: const TextStyle(
                            fontSize: 11.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Text(
                        //   "${transText(context).bill} #$billNumber",
                        //   style: const TextStyle(
                        //     fontSize: 11.1,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.134,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () async {
                          showCircularProgressIndicator(context: context);
                          navigatorPop() => Navigator.pop(context);
                          await generatePDF();
                          navigatorPop();
                          showSnackBar(context, "Receipt Downloaded");
                        },
                        // onPressed: () => showSnackBar(
                        //     context, "Downloaded Receipt Successfully."),
                        icon: const Icon(Icons.download, color: appBlueBg),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "${transText(context).order} #$orderNumber",
                style: const TextStyle(
                  fontSize: 11.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenSize.width * 0.21,
                      child: BoxGrayTextSmaller(
                          "${transText(context).quantity}: $quantity")),
                  // Container(
                  //     alignment: Alignment.center,
                  //     width: screenSize.width * 0.27,
                  //     child:
                  //         BoxGrayTextSmaller("Balance Qty: $balanceQuantity")),
                  Container(
                    alignment: Alignment.topRight,
                    width: screenSize.width * 0.37,
                    child: BoxGrayTextSmaller(
                        "${transText(context).paid}: $paidAmount"),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "INR $amount",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: BoxColors.grayText,
                ),
              ),
              // const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: status.textWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
