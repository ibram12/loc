import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/delete_alert_dialog.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/featuers/admin/data/models/calander_model.dart';

import '../../../../generated/l10n.dart';

class MyData extends DataTableSource {
  final List<DocumentSnapshot> data;
  final BuildContext context;
  MyData(
      {
      required this.data,
      required this.context});

  @override
  DataRow? getRow(int index) {
    final reservation = ClanderModel.fromDoucumentSnapShot(data[index]);

    return DataRow(cells: [
      DataCell(Text(reservation.name)),
      DataCell(Text(reservation.service)),
      DataCell(Text(
          DateFormat('yyyy-MM-dd').format(reservation.startTime.toDate()))),
      DataCell(
          Text(DateFormat('hh:mm a').format(reservation.startTime.toDate()))),
      DataCell(
          Text(DateFormat('hh:mm a').format(reservation.endTime.toDate()))),
      DataCell(IconButton(
          onPressed: () {
            showItemAlertDialog(
                context: context,
                onPressed: () {
                  DataBaseMethouds().deleteRequestFromAdminPanel(
                      userId: reservation.userId,
                      requestId: reservation.requestId,
                      hallId: reservation.hallId,
                      requestIdInReservation: data[index].id);

                  Navigator.of(context).pop();
                  showSnackBar(context, S.of(context).request_deleted_successfully);
                },

                title: S.of(context).delete_request_alert,
                content:
                    "${S.of(context).request_which_belongs_to} ${reservation.name}");
          },
          icon: const Icon(Icons.delete))),
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
