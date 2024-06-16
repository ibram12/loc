
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

class ChatBuble extends StatelessWidget {
const ChatBuble({Key?key, }) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 22, bottom: 22, right: 16),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            color: kPrimaryColor),
        child: const Text(
          "hallo, iam ramy",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}



class ChatBubleForFriend extends StatelessWidget {
const   ChatBubleForFriend({Key?key,}) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 22, bottom: 22, right: 16),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32)),
            color: Color(0xff006D84)),
        child: const Text(
          "hallo, iam ramez",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
