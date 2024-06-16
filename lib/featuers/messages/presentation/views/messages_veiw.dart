import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

import '../../../../generated/l10n.dart';
import 'widgets/messages_view_body.dart';

class MessagesVeiw extends StatelessWidget {
  const MessagesVeiw({super.key});
static const id = 'MessagesVeiw';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(S.of(context).messages),
      ),
      body: const MessagesViewBody(),
    );
  }
}