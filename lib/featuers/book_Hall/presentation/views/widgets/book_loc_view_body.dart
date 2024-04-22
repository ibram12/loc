import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class BookLocViewBody extends StatefulWidget {
  const BookLocViewBody({super.key});
  @override
  State<BookLocViewBody> createState() => _BookLocViewBodyState();
}

class _BookLocViewBodyState extends State<BookLocViewBody> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _date;

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null && pickedStartTime != _startTime) {
      setState(() {
        _startTime = pickedStartTime;
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null && pickedEndTime != _endTime) {
      setState(() {
        _endTime = pickedEndTime;
      });
    }
  }
  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(onPressed: () => selectDate(context),
           child: Text(_date != null ? '${_date!.year}/${_date!.month}/${_date!.day}' : S.of(context).choose_date)),
         const SizedBox(height: 15),

          ElevatedButton(
            onPressed: () => _selectStartTime(context),
            child: Text(_startTime != null
                ? '${S.of(context).start_time}: ${_startTime!.format(context)}'
                : S.of(context).set_start_time),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectEndTime(context),
            child: Text(_endTime != null
                ? '${S.of(context).end_time}: ${_endTime!.format(context)}'
                : S.of(context).set_end_time),
          ),
          const SizedBox(height: 20),
          if (_startTime != null && _endTime != null)
            Text(
                '${S.of(context).time_range}: ${_startTime!.format(context)} - ${_endTime!.format(context)}'),
        ],
      ),
    );
  }
}
