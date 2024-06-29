import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/time_line/presentation/manager/show_time_line_cubit/show_time_line_cubit.dart';
import 'package:loc/featuers/time_line/presentation/views/widgets/time_line_view_body.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../generated/l10n.dart';

class TimeLineVeiw extends StatefulWidget {
  final CalendarView calendarView;
  const TimeLineVeiw({super.key, required this.calendarView});
  static String id = 'time_line_view';

  @override
  State<TimeLineVeiw> createState() => _TimeLineVeiwState();
}

class _TimeLineVeiwState extends State<TimeLineVeiw> {
  late CalendarView calendarView;
  int indexOfView = 0;

  @override
  void initState() {
    super.initState();
    calendarView = widget.calendarView;
    indexOfView = kCalendarViews.indexOf(calendarView);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowTimeLineCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  indexOfView = (indexOfView + 1) % kCalendarViews.length;
                  calendarView = kCalendarViews[indexOfView];
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimeLineVeiw(calendarView: calendarView),
                  ),
                );
              },
              icon: const Icon(Icons.table_view_rounded),
            ),
          ],
          elevation: 0,
          forceMaterialTransparency: true,
          title: Text(S.of(context).time_line),
        ),
        body: TimeLineViewBody(
          calendarView: calendarView,
        ),
      ),
    );
  }
}
