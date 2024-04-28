import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'halls_list_view.dart';

class AllLocsViewBody extends StatelessWidget {
  const AllLocsViewBody({super.key, required this.startTime, required this.endTime});
  final Timestamp startTime;
  final Timestamp endTime;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
      HallsListView(
      startTime:  startTime,
      endTime:  endTime,
      ),
     ]);
  }
}
