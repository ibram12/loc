import 'package:flutter/material.dart';

import '../father class/TimeActivity.dart';


class card_DateTime extends StatefulWidget {
  final Function(TimeActivity?) onDateTimeSelected;

  card_DateTime({Key? key, required this.onDateTimeSelected}) : super(key: key);

  @override
  State<card_DateTime> createState() => _card_DateTimeState();
}

class _card_DateTimeState extends State<card_DateTime> {
  TimeActivity? timeActivity;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // ... your date and time picking logic
        // Select start date
        DateTime? pickedStartDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );

        if (pickedStartDate != null) {
          // Select start time
          TimeOfDay? pickedStartTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedStartTime != null) {
            setState(() {
              timeActivity = TimeActivity(
                startTime: DateTime(
                  pickedStartDate.year,
                  pickedStartDate.month,
                  pickedStartDate.day,
                  pickedStartTime.hour,
                  pickedStartTime.minute,
                ),
                endTime: timeActivity?.endTime,
              );
            });
          }
        }

        // Select end date
        DateTime? pickedEndDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedEndDate != null) {
          // Select end time
          TimeOfDay? pickedEndTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedEndTime != null) {
            setState(() {
              timeActivity = TimeActivity(
                startTime: timeActivity?.startTime,
                endTime: DateTime(
                  pickedEndDate.year,
                  pickedEndDate.month,
                  pickedEndDate.day,
                  pickedEndTime.hour,
                  pickedEndTime.minute,
                ),
              );
            });
          }
        }
        // Notify the parent widget about the selected timeActivity
        widget.onDateTimeSelected(timeActivity);
      },
      child: const Text("Select Dates"),
    );
  }
}


