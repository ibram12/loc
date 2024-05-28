import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/views/book_loc_view.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:loc/widget/Card_Button.dart';

import 'featuers/admin/pressntation/view/bottomNav_bar.dart';
import 'generated/l10n.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key,});
  static const String id = "MyHomePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(S.of(context).halls,style: Styles.textStyle18,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Card_Button(page: BookLocView(), text: 'Add Event'),
            Card_Button(page: const BottomNavBar(), text: S.of(context).add_khdma),
            const Card_Button(page: UserRequests(), text: 'your requests'),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
