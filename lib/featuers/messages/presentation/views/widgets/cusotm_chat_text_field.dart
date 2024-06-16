import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';

class CusotmChatTextField extends StatelessWidget {
  const CusotmChatTextField({super.key});
 
  @override
  Widget build(BuildContext context) {
    return   Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              //controller: controller,
              // onSubmitted: (data) {
              //   BlocProvider.of<ChatCubit>(context)
              //       .SentMassege(email: email, massege: data);
              //   controller.clear();
              //   _controller.animateTo(0,
              //       duration: const Duration(milliseconds: 500),
              //       curve: Curves.easeIn);
              // },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16)),
                  //  borderSide: const BorderSide(color: )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    )
                    
              ),
            ),
          );
  }
}