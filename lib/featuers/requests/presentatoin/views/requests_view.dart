import 'package:flutter/material.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/requests_view_body.dart';

import '../../../../core/utils/constants.dart';

class UserRequests extends StatelessWidget {
  const UserRequests({super.key});
  static const String id = "UserRequests";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:  const Text('your requests'),
      ),
      body: const UserRequestBody(),
    );
  }
}