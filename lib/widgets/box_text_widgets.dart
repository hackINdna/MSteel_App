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

class BiggerBoxHeadingText extends StatelessWidget {
  const BiggerBoxHeadingText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    );
  }
}

class SmallerBoxText extends StatelessWidget {
  final String text;
  const SmallerBoxText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}

class BiggerGrayText extends StatelessWidget {
  final String text;
  const BiggerGrayText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 15, color: BoxColors.grayText, fontWeight: FontWeight.w600),
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

class BoxGrayTextSmaller extends StatelessWidget {
  final String text;
  const BoxGrayTextSmaller(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 11.1,
          color: BoxColors.grayText,
          fontWeight: FontWeight.w600),
    );
  }
}

class OffBlackText extends StatelessWidget {
  final String text;
  const OffBlackText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Color(0xff454545),
          fontSize: 12.9,
          fontWeight: FontWeight.w600),
    );
  }
}
