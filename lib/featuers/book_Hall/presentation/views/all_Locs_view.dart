import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/all_locs_view_body.dart';

import '../../../../generated/l10n.dart';

class AllLocsView extends StatelessWidget {
  const AllLocsView({super.key, required this.startTime, required this.endTime});
  final Timestamp startTime;
  final Timestamp endTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(S.of(context).book_hall),
      ),
      body:  AllLocsViewBody(
startTime:  startTime,
endTime: endTime,
      ),
    );
  }
}