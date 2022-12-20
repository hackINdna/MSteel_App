// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:m_steel/data_models/models.dart';
import 'package:m_steel/make_payment.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';
import 'package:m_steel/widgets/subscription_plan_container.dart';

class SubscriptionDialog extends StatefulWidget {
  final SubscriptionData subscriptionData;
  const SubscriptionDialog(
    this.subscriptionData, {
    Key? key,
  }) : super(key: key);

  @override
  State<SubscriptionDialog> createState() => _SubscriptionDialogState();
}

class _SubscriptionDialogState extends State<SubscriptionDialog> {
  late List<SubscriptionPlanVariant> planDetails;
  SubscriptionPlanVariant? selectedPlan;

  void _selectPlan(SubscriptionPlanVariant plan) {
    setState(() {
      selectedPlan = plan;
    });
  }

  @override
  void initState() {
    super.initState();
    planDetails = widget.subscriptionData.planVariants;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: screenSize.height * 0.53,
          width: screenSize.width * 0.93,
          //margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appBlueBg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Get ${widget.subscriptionData.title.capitalize()}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  color: (selectedPlan != null) ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 44),
              // Container(
              //   color: Colors.orange,
              //   alignment: Alignment.center,
              //   width: double.maxFinite,
              //   child:
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: screenSize.height * 0.2,
                  crossAxisCount: planDetails.length,
                ),

                itemBuilder: (context, index) => InkWell(
                  onTap: () => _selectPlan(planDetails[index]),
                  child: SubscriptionPlanBox(
                    header: planDetails[index].header,
                    months: planDetails[index].months,
                    price: planDetails[index].price,
                    isSelected: planDetails[index] == selectedPlan,
                  ),
                ),
                itemCount: planDetails.length,
                // itemBuilder: (context, index) {
                //   return Stack(
                //     alignment: Alignment.topCenter,
                //     children: [
                //       Container(
                //         margin: EdgeInsets.only(top: 10),
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.black)),
                //         width: double.maxFinite,
                //         height: 200,
                //         child: Text("Raja"),
                //       ),
                //       Positioned(
                //         top: 0,
                //         child: Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             color: Colors.black,
                //           ),
                //           height: 20,
                //           width: 40,
                //           child: Text(
                //             "Offer",
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         ),
                //       ),
                //     ],
                //   );
                // },
              ),
              // )
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPlan == null) {
                      return;
                    }
                    print(
                        "months = ${selectedPlan!.months}, price=${selectedPlan!.price}, title=${widget.subscriptionData.title}");
                    var nav = Navigator.of(context);
                    nav.pop();
                    nav.pushNamed(MakePaymentScreen.routeName,
                        arguments: selectedPlan?.price);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        selectedPlan != null ? appBlueBg : Colors.black,
                    backgroundColor: Colors.white,
                    fixedSize: Size(screenSize.width * 0.71, 39),
                  ),
                  child: Text(transText(context).contnue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
