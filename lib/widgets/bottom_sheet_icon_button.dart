import "package:flutter/material.dart";
import 'package:m_steel/util/general.dart';

class BottomSheetIconButton extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final double? size;
  final Color? bgColor;
  const BottomSheetIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.size,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 53,
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(53),
        color: bgColor ?? appBlueBg,
      ),
      child: Center(
          child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: Colors.white,
          size: size,
        ),
      )),
    );
  }
}
