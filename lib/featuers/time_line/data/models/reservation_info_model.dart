import 'package:flutter/material.dart';
import 'package:loc/featuers/time_line/data/models/reservation_model.dart';

import '../../../../core/utils/constants.dart';

class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    required this.key,
    required this.hallName,
    required this.userName,
  });

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String key;
  String hallName;
  String userName;

  factory Meeting.fromReservatoinModel(
      ReservatoinModel reservation, String id, String hallName) {
    Color color = kServiceColors[reservation.serviceName] ?? Colors.grey;
    return Meeting(
      userName: reservation.userName,
      hallName: hallName,
      eventName: reservation.serviceName,
      from: reservation.startTime.toDate(),
      to: reservation.endTime.toDate(),
      background: color,
      isAllDay: false,
      key: id,
    );
  }
}
