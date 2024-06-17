import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';

import '../../../../generated/l10n.dart';
import '../manager/sent_message_cubit/sent_message_cubit.dart';
import 'widgets/messages_view_body.dart';

class MessagesVeiw extends StatelessWidget {
  const MessagesVeiw({super.key});
static const id = 'MessagesVeiw';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SentMessageCubit(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            title: Text(S.of(context).messages),
          ),
          body: const MessagesViewBody(),
        ),
    );
  }
}