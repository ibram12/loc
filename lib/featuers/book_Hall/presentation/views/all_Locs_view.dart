import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/all_locs_view_body.dart';

import '../../../../generated/l10n.dart';

class AllLocsView extends StatelessWidget {
  const AllLocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(S.of(context).book_hall),
      ),
      body: const AllLocsViewBody(),
    );
  }
}