import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class GradientBgContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const GradientBgContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: gradientBoxDecoration(),
      color: appBlueBg,
      padding: padding,
      child: child,
    );
  }
}
