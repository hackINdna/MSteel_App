import 'package:flutter/material.dart';
import 'package:m_steel/util/general.dart';

class DrawerListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  bool selected = false;
  DrawerListTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: themeColors.last,
      selectedColor: Colors.white,
      selected: selected,
      onTap: () => onTap.call(),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
