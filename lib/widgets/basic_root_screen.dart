import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class RootColumn extends StatelessWidget {
  final List<Widget> children;
  final String? heading;
  late List<Widget> finalChildren;
  final EdgeInsetsGeometry? screenPadding;
  RootColumn({
    super.key,
    this.heading,
    this.screenPadding,
    required this.children,
  }) {
    finalChildren = [
      const SizedBox(height: 3),
      (heading != null) ? headingText(heading!) : const SizedBox(height: 0),
      (heading != null)
          ? const SizedBox(height: 20)
          : const SizedBox(height: 0),
    ];
    finalChildren.addAll(children);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppbar(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: screenPadding ??
              const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: finalChildren,
          ),
        ),
      ),
    );
  }
}
