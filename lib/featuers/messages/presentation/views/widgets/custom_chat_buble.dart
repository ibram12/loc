import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/data/models/chat_buble_model.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key, required this.bubleModel,
  }) : super(key: key);
  final ChatBubleModel bubleModel;
  @override
  Widget build(BuildContext context) {
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
        child:  Column(
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
            Row(
             mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat("hh:mm a").format(bubleModel.time),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.done_all,
                  size: 10,
                  color: Colors.cyan,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key, required this.bubleModel,
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
        child:  Column(
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
              DateFormat("hh:mm a").format(bubleModel.time),
              style: const TextStyle(fontSize: 10, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
