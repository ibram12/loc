import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/presentation/manager/reed_messages_cubit/reed_messages_cubit.dart';


import '../../../../generated/l10n.dart';

import '../../data/models/chat_buble_model.dart';
import '../manager/sent_message_cubit/sent_message_cubit.dart';
import 'widgets/messages_view_body.dart';

class MessagesVeiw extends StatelessWidget {
const   MessagesVeiw({super.key});
  static const id = 'MessagesVeiw';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SentMessageCubit(
            Hive.box<ChatBubleModel>(kMessagesBox)
          ),
        ),
        BlocProvider(
          create: (context) => DeleteOldMessagesCubit(
        
        ),
        ),
      ],
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
