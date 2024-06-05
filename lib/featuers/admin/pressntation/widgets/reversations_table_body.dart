import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/admin/data/models/calander_model.dart';

class MyData extends  DataTableSource{
  final List<DocumentSnapshot> data;

  MyData({required this.data});
  

 @override
  DataRow? getRow(int index) {
    final reservation = ClanderModel.fromDoucumentSnapShot(data[index]);

    return DataRow(
      cells: [
      DataCell(Text(reservation.name)),
      DataCell(Text(reservation.service)),
      DataCell(Text(DateFormat('yyyy-MM-dd').format(reservation.startTime.toDate()))),
      DataCell(Text(DateFormat('hh:mm a').format(reservation.startTime.toDate()))),
      DataCell(Text(DateFormat('hh:mm a').format(reservation.endTime.toDate()))),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

} 