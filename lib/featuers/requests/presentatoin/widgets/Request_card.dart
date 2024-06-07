import 'package:flutter/material.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';

import '../../../../generated/l10n.dart';

class RequstCard extends StatelessWidget {
  const RequstCard(
      {super.key, required this.requestModel, required this.child,});
  final UserRequestModel requestModel;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Banner(
      message: requestModel.daily == false ? S.of(context).not_daily : S.of(context).daily,
      location: BannerLocation.topEnd,
      color: requestModel.daily == false ? Colors.red : Colors.green,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(padding: const EdgeInsets.all(10), child: child),
      ),
    );
  }
}
