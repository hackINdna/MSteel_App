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
      PipeDetails(pipeSize: "1\"", pipeName: "Section Pipe", fields: [
        {
          "Thickness": "1.0",
          "Weight Per Pes.": "5",
          "32 OD Qty.(Round Pipe)": 0,
          "25x25 Qty.(Square Pipe)": 0,
        },
        {
          "Thickness": "1.20",
          "Weight Per Pes.": "6",
          "32 OD Qty.(Round Pipe)": 11.630,
          "25x25 Qty.(Square Pipe)": 0,
        },
        {
          "Thickness": "1.60",
          "Weight Per Pes.": "7",
          "32 OD Qty.(Round Pipe)": 0.440,
          "25x25 Qty.(Square Pipe)": 0,
        },
        {
          "Thickness": "2.0",
          "Weight Per Pes.": "9",
          "32 OD Qty.(Round Pipe)": 0,
          "25x25 Qty.(Square Pipe)": 0,
        },
        {
          "Thickness": "2.20",
          "Weight Per Pes.": "11",
          "32 OD Qty.(Round Pipe)": 0,
          "25x25 Qty.(Square Pipe)": 0,
        },
        {
          "Thickness": "2.50",
          "Weight Per Pes.": "12",
          "32 OD Qty.(Round Pipe)": 0,
          "25x25 Qty.(Square Pipe)": 0,
        },
      ]),
      PipeDetails(pipeSize: "1.25\"", pipeName: "Section Pipe", fields: [
        {
          "Thickness": "1.0",
          "Weight Per Pes.": "6",
          "48 OD Qty.(Round Pipe)": 10.920,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
        {
          "Thickness": "1.2",
          "Weight Per Pes.": "7",
          "48 OD Qty.(Round Pipe)": 26.400,
          "32x32 Qty.(Square Pipe)": 1.080,
          "20x40 Qty.(RectAngle)": 4.610,
        },
        {
          "Thickness": "1.5",
          "Weight Per Pes.": "8.5",
          "48 OD Qty.(Round Pipe)": 23.060,
          "32x32 Qty.(Square Pipe)": 16.900,
          "20x40 Qty.(RectAngle)": 4.990,
        },
        {
          "Thickness": "1.9",
          "Weight Per Pes.": "11",
          "48 OD Qty.(Round Pipe)": 16.400,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
        {
          "Thickness": "2.20",
          "Weight Per Pes.": "13",
          "48 OD Qty.(Round Pipe)": 0,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
        {
          "Thickness": "2.50",
          "Weight Per Pes.": "15",
          "48 OD Qty.(Round Pipe)": 0,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
      ]),
      PipeDetails(pipeSize: "1.5\"", pipeName: "Section Pipe", fields: [
        {
          "Thickness": "1.0",
          "Weight Per Pes.": "6",
          "48 OD Qty.(Round Pipe)": 10.920,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
        {
          "Thickness": "1.2",
          "Weight Per Pes.": "7",
          "48 OD Qty.(Round Pipe)": 26.400,
          "32x32 Qty.(Square Pipe)": 1.080,
          "20x40 Qty.(RectAngle)": 4.610,
        },
        {
          "Thickness": "1.5",
          "Weight Per Pes.": "8.5",
          "48 OD Qty.(Round Pipe)": 23.060,
          "32x32 Qty.(Square Pipe)": 16.900,
          "20x40 Qty.(RectAngle)": 4.990,
        },
        {
          "Thickness": "1.9",
          "Weight Per Pes.": "11",
          "48 OD Qty.(Round Pipe)": 16.400,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
        {
          "Thickness": "2.20",
          "Weight Per Pes.": "13",
          "48 OD Qty.(Round Pipe)": 0,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
        {
          "Thickness": "2.50",
          "Weight Per Pes.": "15",
          "48 OD Qty.(Round Pipe)": 0,
          "32x32 Qty.(Square Pipe)": 0,
          "20x40 Qty.(RectAngle)": 0,
        },
      ]),
      PipeDetails(pipeSize: "2\"", pipeName: "Section Pipe", fields: [
        {
          "Thickness": "1.0",
          "Weight Per Pes.": "9",
          "60 OD Qty.(Round Pipe)": 10.350,
          "48x48 Qty.(Square Pipe)": 0,
          "68x25 Qty.(Rectangle)": 0,
          "40x60 Qty.(Rectangle)": 0,
        },
        {
          "Thickness": "1.2",
          "Weight Per Pes.": "9",
          "60 OD Qty.(Round Pipe)": 2.540,
          "48x48 Qty.(Square Pipe)": 0,
          "68x25 Qty.(Rectangle)": 12.890,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "1.2",
          "Weight Per Pes.": "(17.5 feet)",
          "60 OD Qty.(Round Pipe)": 0,
          "48x48 Qty.(Square Pipe)": 2.970,
          "68x25 Qty.(Rectangle)": 0,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "1.4",
          "Weight Per Pes.": "12.5",
          "60 OD Qty.(Round Pipe)": 0,
          "48x48 Qty.(Square Pipe)": 23.500,
          "68x25 Qty.(Rectangle)": 0,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "1.6",
          "Weight Per Pes.": "14",
          "60 OD Qty.(Round Pipe)": 32.440,
          "48x48 Qty.(Square Pipe)": 55.500,
          "68x25 Qty.(Rectangle)": 42.650,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "1.8",
          "Weight Per Pes.": "15.5",
          "60 OD Qty.(Round Pipe)": 0,
          "48x48 Qty.(Square Pipe)": 0,
          "68x25 Qty.(Rectangle)": 0,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "2.0",
          "Weight Per Pes.": "17",
          "60 OD Qty.(Round Pipe)": 0,
          "48x48 Qty.(Square Pipe)": 0,
          "68x25 Qty.(Rectangle)": 11.050,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "2.20",
          "Weight Per Pes.": "19",
          "60 OD Qty.(Round Pipe)": 0,
          "48x48 Qty.(Square Pipe)": 0,
          "68x25 Qty.(Rectangle)": 0,
          "40x60 Qty.(R-Angle)": 0,
        },
        {
          "Thickness": "2.50",
          "Weight Per Pes.": "21",
          "60 OD Qty.(Round Pipe)": 0,
          "48x48 Qty.(Square Pipe)": 0,
          "68x25 Qty.(Rectangle)": 0,
          "40x60 Qty.(R-Angle)": 0,
        },
      ]),
      PipeDetails(pipeSize: "2.5\"", pipeName: "Section Pipe", fields: [
        {
          "Thickness": "1.6",
          "Weight Per Pes.": "18",
          "76 OD Qty.(Round Pipe)": 34.650,
          "62x62 Qty.(Square Pipe)": 3.670,
          "80x40 Qty.(Rectangle)": 11.860,
        },
        {
          "Thickness": "2.0",
          "Weight Per Pes.": "23",
          "76 OD Qty.(Round Pipe)": 0,
          "62x62 Qty.(Square Pipe)": 0,
          "80x40 Qty.(Rectangle)": 0,
        },
        {
          "Thickness": "2.2",
          "Weight Per Pes.": "25",
          "76 OD Qty.(Round Pipe)": 0,
          "62x62 Qty.(Square Pipe)": 0,
          "80x40 Qty.(Rectangle)": 0,
        },
        {
          "Thickness": "2.5",
          "Weight Per Pes.": "28",
          "76 OD Qty.(Round Pipe)": 8.010,
          "62x62 Qty.(Square Pipe)": 0,
          "80x40 Qty.(Rectangle)": 29.600,
        },
      ])
    ];
