import "package:flutter/material.dart";
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class BankListItem extends StatelessWidget {
  final String image, title, url;
  const BankListItem({
    super.key,
    required this.image,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
      dense: true,
      visualDensity: VisualDensity.comfortable,
      leading: CircleAvatar(backgroundImage: AssetImage(image), radius: 25.1),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.4),
      ),
      trailing: TextButton(
        onPressed: () {
          print(url);
        },
        child: Text(transText(context).checkBalance,
            style: const TextStyle(fontSize: 13.2, color: appBlueBg)),
      ),
    );
  }
}
