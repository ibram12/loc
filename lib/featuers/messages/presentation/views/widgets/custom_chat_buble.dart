
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
            const EdgeInsets.only(left: 16, top: 18, bottom: 18, right: 16),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            color: kPrimaryColor),
        child: const Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "hallo, i am ramy",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 3,),
            Text("2:30 AM",style: TextStyle(
              fontSize: 10,
              color: Colors.black
            ),
            )
          ],
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
            color: Colors.lightGreen),
        child: const Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "hallo, i am ramy",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 3,),
            Text("2:30 AM",style: TextStyle(
              fontSize: 10,
              color: Colors.black
            ),
            )
          ],
        ),
      ),
    );
  }
}
