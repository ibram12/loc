import 'package:flutter/cupertino.dart';
import 'package:loc/featuers/messages/presentation/views/widgets/cusotm_chat_text_field.dart';
import 'package:loc/featuers/messages/presentation/views/widgets/custom_chat_buble.dart';

class MessagesViewBody extends StatelessWidget {
  const MessagesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ChatBuble();
            },
          ),
        ),
        const CusotmChatTextField(),
      ],
    );
  }
}