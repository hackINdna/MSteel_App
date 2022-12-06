import "package:flutter/material.dart";
import 'package:m_steel/util/general.dart';

class BottomSheetIconButton extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  const BottomSheetIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 53,
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(53),
        color: appBlueBg,
      ),
      child: Center(
          child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
      )),
    );
  }
}
