import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/pressntation/widgets/admin_view_body.dart';

import '../../../../generated/l10n.dart';
import 'add_hall_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).add_hall),
      ),
      body: const AdminViewBody(),
    );
  }
}