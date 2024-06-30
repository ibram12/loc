import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import '../../../messages/presentation/views/messages_veiw.dart';
import 'package:loc/featuers/messages/presentation/manager/unread_messages_counter_provider.dart';

class MessagesBotton extends StatefulWidget {
  const MessagesBotton({super.key});

  @override
  State<MessagesBotton> createState() => _MessagesBottonState();
}

class _MessagesBottonState extends State<MessagesBotton> {
  @override
  void initState() {
    super.initState();
    Provider.of<MessageCountProvider>(context, listen: false).getMessagesCount();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool? reset = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MessagesVeiw(),
          ),
        );
        if (reset == true) {
          Provider.of<MessageCountProvider>(context, listen: false).resetMessageCount();
        } else {
          Provider.of<MessageCountProvider>(context, listen: false).getMessagesCount();
        }
      },
      child: Stack(
        children: [
          Row(
            children: [
              Text(
                S.of(context).messages,
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Icon(Icons.message),
              ),
            ],
          ),
          Consumer<MessageCountProvider>(
            builder: (context, value, child) {
              if (value.messageCount == 0) {
                return Container();
              }
              return Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text("${value.messageCount}"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
