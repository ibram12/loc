import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/view/admin_view.dart';
import 'package:loc/featuers/book_Hall/presentation/views/book_loc_view.dart';
import 'package:loc/screen/add%20activity.dart';
import 'package:loc/featuers/book_Hall/presentation/views/all_Locs_view.dart';
import 'package:loc/widget/Card_Button.dart';

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
          children: <Widget>[
            Card_Button(page: const BookLocView(), text: S.of(context).book_hall),
            Card_Button(page: const AdminView(), text: S.of(context).add_khdma),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
