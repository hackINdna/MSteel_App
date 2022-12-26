//sample order statements list
import 'package:m_steel/data_models/models.dart';

var currDate = DateTime.now();

//order statements
List<OrderDetailsData> getSampleOrderStatementsNEW() {
  return [
    OrderDetailsData(
      "MS/47/19-20",
      "Sharda TMT (EX-Nagpur)",
      "15",
      "15",
      "277000",
      currDate.toString(),
      "pending",
    ),
    OrderDetailsData(
      "MS/47/19-20",
      "Sharda TMT (EX-Nagpur)",
      "15",
      "15",
      "277000",
      currDate.toString(),
      "shippingInProcess",
    ),
  ];
}

List<OrderDetailsData> getSampleOrderStatementsOLD() {
  return [
    OrderDetailsData(
      "MS/47/19-20",
      "Sharda TMT (EX-Nagpur)",
      "15",
      "15",
      "277000",
      currDate.toString(),
      "approved",
    ),
  ];
}

//my bills
var billDate1 = DateTime.parse('2023-01-01');
var billDate2 = DateTime.parse('2022-12-12');
List<BillData> getBillData() => [
      BillData("552", "30339", billDate1.toString(), "completed",
          "http:/abc.com/pdf?id=2"),
      BillData("552", "30339", billDate1.toString(), "completed",
          "http:/abc.com/pdf?id=3"),
      BillData("552", "30339", billDate2.toString(), "completed",
          "http:/abc.com/pdf?id=2"),
    ];

//my transactiosn
List<TransactionData> getTransactionData() => [
      TransactionData("Sales Accounts", "552", "30339", "30339", "incompleted",
          billDate1.toString(),
          debit: true),
      TransactionData("Kotak Mahindra", "552", "30339", "30339", "completed",
          billDate2.toString(),
          debit: false),
    ];

//my receipts
List<ReceiptData> getReceiptsData() => [
      ReceiptData(
        orderNumber: "MS/47/19-20",
        billNumber: "552",
        company: "Sharda TMT (EX-Nagpur)",
        quantity: "15",
        balanceQuantity: "15  ",
        bookingRate: "277000",
        date: billDate1.toString(),
        amount: "30339",
        billDownloadLink: "http://abc.pdf",
        status: "completed",
      ),
      ReceiptData(
        orderNumber: "MS/47/19-20",
        billNumber: "552",
        company: "Sharda TMT (EX-Nagpur)",
        quantity: "15",
        balanceQuantity: "15",
        bookingRate: "277000",
        date: billDate2.toString(),
        amount: "30339",
        billDownloadLink: "http://abc.pdf",
        status: "completed",
      ),
    ];

//item Data
List<ItemData> getStateItems() => [
      ItemData(
          categoryName: "MS TMT Bar",
          categorySubtitle: "Ex-Jalna",
          itemSuffix: "TP",
          date: billDate2.toString(),
          amount: "30339",
          items: items),
      ItemData(
          categoryName: "Sharda TMT",
          categorySubtitle: "Ex-Nagpur",
          itemSuffix: "TP",
          date: billDate2.toString(),
          amount: "277000",
          items: items),
      ItemData(
          categoryName: "A-1 Gold Pipes",
          categorySubtitle: "Ex-Nagpur",
          itemSuffix: "TP",
          date: billDate2.toString(),
          amount: "31000",
          items: items),
    ];
Map<String, String> items = {
  "10mm": "30339",
  "12mm": "30339",
  "16mm": "30339",
  "20mm": "30339",
  "25mm": "30339",
};

//subscription Data
List<SubscriptionData> getSubscriptionData() => [
      SubscriptionData(
          title: "PLATINUM",
          subtitle: "Eu tempus egestas arcu volutpat leo id quam lectus sed.",
          planVariants: [
            SubscriptionPlanVariant(months: "12", price: "700"),
            SubscriptionPlanVariant(
                months: "6", price: "300", header: "Most Popular"),
            SubscriptionPlanVariant(months: "1", price: "150"),
          ]),
      SubscriptionData(
          title: "GOLD",
          subtitle: "Velit fermentum sed volutpat et sed ac enim.",
          planVariants: [
            SubscriptionPlanVariant(months: "12", price: "800"),
            SubscriptionPlanVariant(months: "6", price: "400"),
            SubscriptionPlanVariant(months: "1", price: "100"),
          ]),
    ];

// stock statements pipe table data
List<PipeDetails> getpipeDetails() => [
      PipeDetails(pipeSize: "1\"", pipeName: "Section Pipe", specs: [
        PipeSpecs(
          thickness: "1.00",
          wpp: "5",
          qty1: null,
          qty2: null,
        ),
        PipeSpecs(thickness: "1.20", wpp: "6", qty1: 11.630, qty2: null),
        PipeSpecs(thickness: "1.60", wpp: "7", qty1: 0.440, qty2: null),
        PipeSpecs(thickness: "2.00", wpp: "9", qty1: null, qty2: null),
        PipeSpecs(thickness: "2.20", wpp: "11", qty1: null, qty2: null),
        PipeSpecs(thickness: "2.50", wpp: "12", qty1: null, qty2: null),
      ]),
      PipeDetails(pipeSize: "1.25\"", pipeName: "Section Pipe", specs: [
        PipeSpecs(thickness: "1.00", wpp: "5", qty1: null, qty2: 5),
        PipeSpecs(
            thickness: "1.20", wpp: "6", qty1: 11.630, qty2: 6, qty3: 4.610),
        PipeSpecs(
            thickness: "1.60", wpp: "7", qty1: 0.440, qty2: 7, qty3: 4.990),
        PipeSpecs(thickness: "2.00", wpp: "9", qty1: null, qty2: 9),
        PipeSpecs(thickness: "2.20", wpp: "11", qty1: null, qty2: 11),
        PipeSpecs(thickness: "2.50", wpp: "12", qty1: null, qty2: 12),
      ]),
      PipeDetails(pipeSize: "2.0\"", pipeName: "Section Pipe", specs: [
        PipeSpecs(thickness: "1.00", wpp: "5", qty1: null, qty2: 5),
        PipeSpecs(thickness: "1.20", wpp: "6", qty1: 11.630, qty2: 6),
        PipeSpecs(thickness: "1.60", wpp: "7", qty1: 0.440, qty2: 7),
        PipeSpecs(thickness: "2.00", wpp: "9", qty1: null, qty2: 9),
        PipeSpecs(thickness: "2.20", wpp: "11", qty1: null, qty2: 11),
        PipeSpecs(thickness: "2.50", wpp: "12", qty1: null, qty2: 12),
      ]),
      PipeDetails(pipeSize: "0.75\"", pipeName: "Section Pipe", specs: [
        PipeSpecs(thickness: "1.00", wpp: "5", qty1: null, qty2: 5),
        PipeSpecs(thickness: "1.20", wpp: "6", qty1: 11.630, qty2: 6),
        PipeSpecs(thickness: "1.60", wpp: "7", qty1: 0.440, qty2: 7),
        PipeSpecs(thickness: "2.00", wpp: "9", qty1: null, qty2: 9),
        PipeSpecs(thickness: "2.20", wpp: "11", qty1: null, qty2: 11),
        PipeSpecs(thickness: "2.50", wpp: "12", qty1: null, qty2: 12),
      ]),
      PipeDetails(pipeSize: "2.5\"", pipeName: "Section Pipe", specs: [
        PipeSpecs(
            thickness: "1.00", wpp: "5", qty1: null, qty2: 5, qty3: 11.860),
        PipeSpecs(thickness: "1.20", wpp: "6", qty1: 11.630, qty2: 6),
        PipeSpecs(thickness: "1.60", wpp: "7", qty1: 0.440, qty2: 7),
        PipeSpecs(thickness: "2.00", wpp: "9", qty1: null, qty2: 9),
        PipeSpecs(
            thickness: "2.20", wpp: "11", qty1: null, qty2: 11, qty3: 29.600),
        PipeSpecs(thickness: "2.50", wpp: "12", qty1: null, qty2: 12),
      ]),
      PipeDetails(pipeSize: "", pipeName: "Random Pipe", specs: [
        PipeSpecs(thickness: "1.00", wpp: "5", qty1: null, qty2: 5),
        PipeSpecs(thickness: "1.20", wpp: "6", qty1: 11.630, qty2: 6),
        PipeSpecs(thickness: "1.60", wpp: "7", qty1: 0.440, qty2: 7),
        PipeSpecs(thickness: "2.00", wpp: "9", qty1: null, qty2: 9),
        PipeSpecs(thickness: "2.20", wpp: "11", qty1: null, qty2: 11),
        PipeSpecs(thickness: "2.50", wpp: "12", qty1: null, qty2: 12),
      ]),
    ];
