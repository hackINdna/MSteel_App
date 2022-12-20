import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_steel/util/general.dart';
import 'package:m_steel/util/language_constants.dart';

class ContactAdminDialog extends StatelessWidget {
  const ContactAdminDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            margin: EdgeInsets.all(screenSize.width * 0.06),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  iconColor: appBlueBg2,
                  textColor: appBlueBg2,
                  onTap: () {},
                  title: Text(
                    transText(context).sendMessage,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
                const Divider(
                  height: 0,
                  color: BoxColors.grayText,
                ),
                const SizedBox(height: 12),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  iconColor: appBlueBg2,
                  textColor: appBlueBg2,
                  onTap: () {},
                  title: Text(
                    transText(context).sendEmail,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
                const Divider(
                  height: 0,
                  color: BoxColors.grayText,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/ic_whatsapp.svg",
                        )),
                    IconButton(
                        onPressed: () {},
                        icon:
                            SvgPicture.asset("assets/icons/ic_instagram.svg")),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/icons/ic_linkedin.svg")),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/icons/ic_twitter.svg")),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/icons/ic_facebook.svg")),
                  ],
                ),
                const SizedBox(height: 3),
              ],
            )),
      ),
    );
  }
}
