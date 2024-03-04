import 'package:flutter/material.dart';
import 'package:loc/screen/add%20activity.dart';
import 'package:loc/screen/addLoc.dart';
import 'package:loc/widget/Card_Button.dart';

import 'generated/l10n.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card_Button(page: addLoc(), text: S.of(context).add_khdma),
            Card_Button(page: AddActivity(), text: S.of(context).add_khdma),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
