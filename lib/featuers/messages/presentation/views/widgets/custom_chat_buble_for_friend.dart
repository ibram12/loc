import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/chat_buble_model.dart';

class ChatBubleForFriend extends StatefulWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.bubleModel,
  }) : super(key: key);
  final ChatBubleModel bubleModel;

  @override
  State<ChatBubleForFriend> createState() => _ChatBubleForFriendState();
}

class _ChatBubleForFriendState extends State<ChatBubleForFriend>
    with SingleTickerProviderStateMixin {
  late Animation<double> scale;
  late AnimationController controller;
  bool isDateShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scale = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  void showDate() {
    setState(() {
      isDateShow = !isDateShow;
    });
    isDateShow ? controller.forward() : controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDate(),
      child: Align(
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
              //  mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: widget.bubleModel.profileImage == ""
                        ? ClipOval(child: Image.asset("assets/images/person.png"))
                        : ClipOval(
                            child: CachedNetworkImage(
                                imageUrl: widget.bubleModel.profileImage,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    )),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.bubleModel.name,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.bubleModel.massege,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 3),
              Text(
                DateFormat("hh:mm a").format(widget.bubleModel.time.toDate()),
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
              const SizedBox(height: 3),
              ScaleTransition(
                  scale: scale,
                  child: isDateShow
                      ? Text(
                          DateFormat("dd MMM")
                              .format(widget.bubleModel.time.toDate()),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black),
                        )
                      : Container(
                          width: 0,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
