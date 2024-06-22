import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import '../../../messages/presentation/views/messages_veiw.dart';

class MessagesBotton extends StatelessWidget {
  const MessagesBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(MessagesVeiw.id),
                child: Row(
                  children: [
                    Text(
                      S.of(context).messages,
                      style: Styles.textStyle16
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  const Spacer(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.message),
                    ),
                  ],
                ),
              );
  }
}