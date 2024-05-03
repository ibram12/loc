import 'package:flutter/material.dart';

import 'request_item.dart';

class RequestsViewBody extends StatelessWidget {
  const RequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return RequestItem();
      });
  }
}
