import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/cubits/cubit/select_time_cubit.dart';

class UserChoices extends StatelessWidget {
  const UserChoices({super.key, this.date, this.startTime, this.endTime});
  final DateTime? date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
var selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    return Column(
      children: [
            ElevatedButton(
                    onPressed: () =>
                        selectTimeCubit.selectDate(context, date),
                    child: Text(date != null
                        ? '${date!.year}/${date!.month}/${date!.day}'
                        : S.of(context).choose_date)),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () =>
                      selectTimeCubit.selectStartTime(context, startTime),
                  child: Text(startTime != null
                      ? '${S.of(context).start_time}: ${startTime!.format(context)}'
                      : S.of(context).set_start_time),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      selectTimeCubit.selectEndTime(context, endTime),
                  child: Text(endTime != null
                      ? '${S.of(context).end_time}: ${endTime!.format(context)}'
                      : S.of(context).set_end_time),
                ),
      ]
    );
  }
}