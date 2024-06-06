
import 'package:flutter/material.dart';

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
          title: const Text('Modify permissions'),
          content: Text('Modify permissions for ${userInfoModel.name}?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: onEditServicesPressed,
                        child: const Text(
                          'Edit Services',
                          style: TextStyle(color: Colors.deepOrange),
                        )),
                    TextButton(
                        onPressed: onEditRolePressed,
                        child: const Text(
                          'Edit Role',
                          style: TextStyle(
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
