import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../widgets/admin_view_body.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).book_hall),
      ),
      body: AdminViewBody(),
    );
  }
}