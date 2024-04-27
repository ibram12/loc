import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/cubits/cubit/select_time_cubit.dart';

class UserChoices extends StatefulWidget {
  const UserChoices({
    super.key,
    this.date, required this.setStartTime, required this.setEndTime,
  });
  final DateTime? date;
  final void Function(TimeOfDay) setStartTime;
  final void Function(TimeOfDay) setEndTime;
  @override
  State<UserChoices> createState() => _UserChoicesState();
}

class _UserChoicesState extends State<UserChoices> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  @override
  Widget build(BuildContext context) {
    var selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    return Column(children: [
      ElevatedButton(
          onPressed: () => selectTimeCubit.selectDate(context, widget.date),
          child: Text(widget.date != null
              ? '${widget.date!.year}/${widget.date!.month}/${widget.date!.day}'
              : S.of(context).choose_date)),
      const SizedBox(height: 15),
      ElevatedButton(
        onPressed: () => selectTimeCubit.selectStartTime(
            context, widget.date ?? DateTime.now(), (pickedSrtartTime) {
          startTime = pickedSrtartTime;
          widget.setStartTime(pickedSrtartTime);
        }),
        child: Text(startTime != null
            ? '${S.of(context).start_time}: ${startTime!.format(context)}'
            : S.of(context).set_start_time),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => selectTimeCubit.selectEndTime(
            context, widget.date ?? DateTime.now(), (pickedEndTime) {
          endTime = pickedEndTime;
          widget.setEndTime(pickedEndTime);
        }),
        child: Text(endTime != null
            ? '${S.of(context).end_time}: ${endTime!.format(context)}'
            : S.of(context).set_end_time),
      ),
    ]);
  }
}
