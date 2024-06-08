import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/featuers/week_time_line/presentation/manager/show_time_line_cubit/show_time_line_cubit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../generated/l10n.dart';
import 'reservations_data_sourece.dart';

class TimeLineViewBody extends StatefulWidget {
  const TimeLineViewBody({super.key});

  @override
  State<TimeLineViewBody> createState() => _TimeLineViewBodyState();
}

class _TimeLineViewBodyState extends State<TimeLineViewBody> {
  MeetingDataSource? events;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowTimeLineCubit>(context).getTheTimeLine().then(
      (results) {
        SchedulerBinding.instance.addPostFrameCallback((timesTamp) {
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowTimeLineCubit, ShowTimeLineState>(
      builder: (context, state) {
        if (state is ShowTimeLineLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShowTimeLineSuccess) {
          events = MeetingDataSource(state.reservations);
        } else if (state is ShowTimeLineError) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return SfCalendar(
           minDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
           maxDate: DateTime(DateTime.now().year, DateTime.now().month + 2, 0),
          
          onTap: (CalendarTapDetails date) {
            if (date.appointments != null) {
              showAlertDialog(
                  context: context,
                  message:
                      '${date.appointments![0].userName} ${S.of(context).home_made_a_reservation_from} ${DateFormat('hh:mm a').format(date.appointments![0].from)} ${S.of(context).to} ${DateFormat('hh:mm a').format(date.appointments![0].to)} ${S.of(context).forr} ${date.appointments![0].eventName} ${S.of(context).inn} ${date.appointments![0].hallName}',
                  onOkPressed: () => Navigator.pop(context));
            } else {}
          },
          view: CalendarView.workWeek,
          firstDayOfWeek: 6,
          showDatePickerButton: true,
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeIntervalHeight: 60,
            startHour: 6,
            
            endHour: 23,
            nonWorkingDays: [],
          ),
          dataSource: events,
        );
      },
    );
  }
}
