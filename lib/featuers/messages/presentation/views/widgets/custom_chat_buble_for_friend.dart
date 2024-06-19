import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/chat_buble_model.dart';

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
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Colors.lightGreen,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                  CircleAvatar(
                      radius: 18,
                      child: bubleModel.profileImage == ""
                          ?  Image.asset("assets/images/person.png")
                          : ClipOval(
                            child: CachedNetworkImage(
                                    imageUrl: bubleModel.profileImage,
                                    placeholder: (context, url) => const CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    )
                                    ),
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      bubleModel.name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              bubleModel.massege,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 3),
            Text(
              DateFormat("hh:mm a").format(bubleModel.time.toDate()),
              style: const TextStyle(fontSize: 10, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
