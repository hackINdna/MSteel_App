import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class BoxHeadingText extends StatelessWidget {
  final String text;
  const BoxHeadingText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class BoxGrayText extends StatelessWidget {
  final String text;
  const BoxGrayText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 12, color: BoxColors.grayText, fontWeight: FontWeight.w600),
    );
  }
}
