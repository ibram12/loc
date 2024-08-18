import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/presentation/manager/reed_messages_cubit/reed_messages_cubit.dart';
import 'package:loc/featuers/messages/presentation/manager/unread_messages_counter_provider.dart';
import 'package:provider/provider.dart';


import '../../../../generated/l10n.dart';

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
        
          ),
        ),
        BlocProvider(
          create: (context) => DeleteOldMessagesCubit(
        
        ),
        ),
      ],
      child: PopScope(
            onPopInvoked: (didPop) => didPop ? context.read<MessageCountProvider>().resetMessageCount() : null,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            title: Text(S.of(context).messages),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: const MessagesViewBody(),
        ),
      ),
    );
  }
}
