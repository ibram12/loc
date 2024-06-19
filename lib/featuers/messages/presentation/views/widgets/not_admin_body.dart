import 'package:flutter/material.dart';

import '../../../../../core/text_styles/Styles.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';

class NotAdminBody extends StatelessWidget {
  const NotAdminBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: kPrimaryColor,
          ),
          Text(S.of(context).only_admin_can_send_messages,style: Styles.textStyle18.copyWith(color: kPrimaryColor),),
        ],
      ),
    );
  }
}