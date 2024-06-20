// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../generated/l10n.dart';

void showDitalisDialog({
  required BuildContext context,
  required String message,
  required Function() onOkPressed,
required  CalendarTapDetails data,
}) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        S.of(context).reservation_details,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${S.of(context).user_name}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: data.appointments![0].userName),
                    ],
                  ),
                ),
                Text.rich(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${S.of(context).reservation_time}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        
                        text: '${DateFormat('hh:mm a').format(data.appointments![0].from)} ${S.of(context).to} ${DateFormat('hh:mm a').format(data.appointments![0].to)}',
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${S.of(context).event_name}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: data.appointments![0].eventName),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${S.of(context).hall_name}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: data.appointments![0].hallName),
                    ],
                  ),
                ),
              ],
            ),
          
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            onOkPressed();
          },
          child: Text(
            S.of(context).ok,
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ],
    ),
  );
}
