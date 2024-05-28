import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

import '../../../../generated/l10n.dart';
import '../../../admin/pressntation/view/bottomNav_bar.dart';
import '../../../book_Hall/presentation/views/book_loc_view.dart';
import 'Card_Button.dart';

class HomeVeiwBody extends StatelessWidget {
  const HomeVeiwBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: double.infinity,),
          Image.asset(kLogo),
          const SizedBox(height: 79,),
          const Card_Button(page: BookLocView(), text: 'Add Event'),
          Card_Button(page: const BottomNavBar(), text: S.of(context).add_khdma),
        ],
      ),
    );
  }
}