import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/pressntation/widgets/admin_view_body.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import 'all_requests_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});
  static const String id = 'admin View';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Text(S.of(context).add_hall),
        actions: [
          IconButton(
            onPressed: () =>Navigator.of(context).pushNamed(AllRequests.id),
            icon: const Icon(Icons.edit_document),
          )
        ],
      ),
    
      body: const AdminViewBody(),
    );
  }
}
