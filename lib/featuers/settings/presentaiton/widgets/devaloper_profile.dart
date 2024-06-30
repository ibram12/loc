import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/l10n.dart';

class DevaloperProfile extends StatelessWidget {
  const DevaloperProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
                bottom: 0,
                left: 3,
                child: Row(
                  children: [
                     Text("${S.of(context).developed_by}:"),
                    TextButton(
                      onPressed: () async {
                  final Uri url = Uri.parse("https://www.linkedin.com/in/ramy-el-shahidy-8bab29301/");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                        child: const Text("Ramy Hany"))
                  ],
                ));
  }
}