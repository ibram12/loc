import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/utils/constants.dart';

import '../../manager/sent_message_cubit/sent_message_cubit.dart';

class CusotmChatTextField extends StatefulWidget {
  const CusotmChatTextField({super.key});

  @override
  State<CusotmChatTextField> createState() => _CusotmChatTextFieldState();
}

class _CusotmChatTextFieldState extends State<CusotmChatTextField> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SentMessageCubit, SentMessageState>(
      listener: (context, state) {
        showSnackBar(context, "message sent succfully");
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          onSubmitted: (data) {
            BlocProvider.of<SentMessageCubit>(context)
                .sentMessage(message: controller.text);
            controller.clear();
            // _controller.animateTo(0,
            //     duration: const Duration(milliseconds: 500),
            //     curve: Curves.easeIn);
          },
          decoration: InputDecoration(
              hintText: 'Send Message',
              suffixIcon: const Icon(
                Icons.send,
                color: kPrimaryColor,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              //  borderSide: const BorderSide(color: )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: kPrimaryColor),
              )),
        ),
      ),
    );
  }
}
