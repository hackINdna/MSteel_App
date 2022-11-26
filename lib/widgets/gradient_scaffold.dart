import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class GradientBgScaffold extends StatelessWidget {
  final Widget body;
  const GradientBgScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: body,
      ),
    );
  }
}
