import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loc/featuers/messages/presentation/views/widgets/cusotm_chat_text_field.dart';
import 'package:loc/featuers/messages/presentation/views/widgets/custom_chat_buble.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/chat_buble_model.dart';
import '../../manager/reed_messages_cubit/reed_messages_cubit.dart';

class MessagesViewBody extends StatefulWidget {
  const MessagesViewBody({super.key});

  @override
  State<MessagesViewBody> createState() => _MessagesViewBodyState();
}

class _MessagesViewBodyState extends State<MessagesViewBody> {
  List<ChatBubleModel> messages = [];
  String id = FirebaseAuth.instance.currentUser!.uid;
late ScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ReedMessagesCubit>().getMessages();
  //  Hive.box<ChatBubleModel>(kMessagesBox).clear();
  controller =ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<ReedMessagesCubit, ReedMessagesState>(
            listener: (context, state) {
              if (state is ReedMessagesSuccess) {
                messages = state.messages;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (controller.hasClients) {
                    controller.animateTo(
                      controller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                });
              }
            },
            builder: (context, state) {
              if (state is ReedMessagesLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: controller,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index].id == id ? ChatBuble(
                    bubleModel: messages[index],
                  ): ChatBubleForFriend(
                    bubleModel: messages[index],
                  );
                },
              );
            },
          ),
        ),
         CusotmChatTextField(
          onSent: (){
              controller.animateTo(controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        )
      ],
    );
  }
}
