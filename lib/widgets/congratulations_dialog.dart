import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class CongratulationsDialog extends StatelessWidget {
  const CongratulationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(screenSize.width * 0.08),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                color: appBlueBg,
                height: screenSize.height * 0.17,
                child: Image.asset("assets/images/congratulations.png",
                    fit: BoxFit.fitHeight),
              ),
              const SizedBox(height: 12),
              Text(
                transText(context).congratulations,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 11, bottom: 15),
                child: Text(
                  transText(context).congratulationsSuccessfullMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: BoxColors.grayText, fontSize: 12.9),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 17, 12),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: appBlueBg2),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(transText(context).ok)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
