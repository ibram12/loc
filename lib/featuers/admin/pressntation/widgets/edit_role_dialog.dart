import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/user_info_model.dart';
import '../../../../core/utils/constants.dart';

void showEditRoleDialog(BuildContext context, UserInfoModel userInfoModel, Function(String role) onEditRolePressed) {
  String? selectedRole = userInfoModel.role;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(S.of(context).edit_role),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButton<String>(
              value: selectedRole,
              items: kRoles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newRole) {
                setState(() {
                  selectedRole = newRole;
                });
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child:  Text(S.of(context).cancal),
          ),
          TextButton(
            onPressed: () {
              if (selectedRole != null) {
                onEditRolePressed(selectedRole!);
              }
              Navigator.of(context).pop();
            },
            child:  Text(S.of(context).save),
          ),
        ],
      );
    },
  );
}
