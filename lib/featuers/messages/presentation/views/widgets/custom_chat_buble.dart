import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/messages/data/models/chat_buble_model.dart';


class ChatBuble extends StatefulWidget {
  const ChatBuble({
    Key? key,
    required this.bubleModel,
    required this.index,
  }) : super(key: key);

  final ChatBubleModel bubleModel;
  final int index;

  @override
  State<ChatBuble> createState() => _ChatBubleState();
}

class _ChatBubleState extends State<ChatBuble>
    with SingleTickerProviderStateMixin {
  late Animation<double> scale;
  late AnimationController controller;
  bool showDate = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scale = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleDateVisibility() {
    setState(() {
      showDate = !showDate;
      if (showDate) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleDateVisibility();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: kPrimaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: widget.bubleModel.profileImage == ""
                        ? ClipOval(
                            child: Image.asset("assets/images/person.png"))
                        : ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.bubleModel.profileImage,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat("hh:mm a")
                        .format(widget.bubleModel.time.toDate()),
                    style:
                        const TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                 const Icon(
                          Icons.done_all,
                          size: 10,
                          color: Colors.cyan,
                        )
                      
                ],
              ),
              const SizedBox(height: 3),
              ScaleTransition(
                scale: scale,
                child: showDate
                    ? Text(
                        DateFormat("dd MMM")
                            .format(widget.bubleModel.time.toDate()),
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black),
                      )
                    : Container(
                        width: 0,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
