import 'package:flutter/material.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/request_item.dart';


class UserRequestBody extends StatelessWidget {
  const UserRequestBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
      return const UserRequestItem();
    });
  }
}
