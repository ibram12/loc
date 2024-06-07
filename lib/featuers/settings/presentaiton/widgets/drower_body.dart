import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import 'theme_switcher.dart';
import 'translate_switcher.dart';

class DrowerBody extends StatelessWidget {
  const DrowerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    S.of(context).App_Theme,
                    style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Icon(Icons.brightness_4_sharp),
                const  Spacer(),
                  const SwitchThemeApp(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    S.of(context).App_Language,
                    style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Icon(Icons.translate_sharp),
                const  Spacer(),
                const  TranslateSwitcher()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}