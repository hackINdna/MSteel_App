import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class GradientBgContainer extends StatelessWidget {
  final Widget child;
  const GradientBgContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientBoxDecoration(),
      child: child,
    );
  }
}
