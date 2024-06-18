import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/data/models/chat_buble_model.dart';
import 'package:loc/featuers/messages/presentation/manager/sent_message_cubit/sent_message_cubit.dart';

class ChatBuble extends StatefulWidget {
  const ChatBuble({
    Key? key,
    required this.bubleModel,
  }) : super(key: key);

  final ChatBubleModel bubleModel;

  @override
  State<ChatBuble> createState() => _ChatBubleState();
}

class _ChatBubleState extends State<ChatBuble> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentMessageCubit, SentMessageState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, top: 18, bottom: 18, right: 16),
            margin: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32)),
                color: kPrimaryColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.bubleModel.massege,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat("hh:mm a")
                          .format(widget.bubleModel.time.toDate()),
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    const SizedBox(width: 5),
                    widget.bubleModel.isSent
                        ? const Icon(
                            Icons.done_all,
                            size: 10,
                            color: Colors.cyan,
                          )
                        : Image.asset(
                            "assets/images/9032185_pending_chatting_load_chat_social media_icon.png",
                            height: 12,
                            width: 12,
                          )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.bubleModel,
  }) : super(key: key);
  final ChatBubleModel bubleModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 18, bottom: 18, right: 16),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32)),
            color: Colors.lightGreen),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              bubleModel.massege,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              DateFormat("hh:mm a").format(bubleModel.time.toDate()),
              style: const TextStyle(fontSize: 10, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
