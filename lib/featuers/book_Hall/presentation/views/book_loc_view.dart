import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/book_loc_view_body.dart';

import '../../../../generated/l10n.dart';

class BookLocView extends StatelessWidget {
  const BookLocView({super.key});
  static const String id = "BookLocView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(S.of(context).add_reservation),
      ),
      body: const BookLocViewBody(),
    );
  }
}