
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/user_info_model.dart';

void showModifyUserPermationsDialog({
  required BuildContext context,
  required UserInfoModel userInfoModel,
  required Function() onEditServicesPressed,
  required Function() onEditRolePressed,}) {
  showAdaptiveDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title:  Text(S.of(context).modify_permissions),
          content: Text('${S.of(context).modify_permissions_for} ${userInfoModel.name}?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text(S.of(context).cancal),
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: onEditServicesPressed,
                        child:  Text(
                          S.of(context).edit_services,
                          style: const TextStyle(color: Colors.deepOrange),
                        )),
                    TextButton(
                        onPressed: onEditRolePressed,
                        child:  Text(
                          S.of(context).edit_role,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 248, 224, 4)),
                        )),
                  ],
                ),
              ],
            ),
          ],
        );
      });
}
