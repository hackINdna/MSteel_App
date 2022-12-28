import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class GradientBgScaffold extends StatelessWidget {
  final Widget body;
  const GradientBgScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: gradientBoxDecoration(),//comments due to gradient changed to solid
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        backgroundColor: appBlueBg,
        body: body,
      ),
    );
  }
}
