import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/timeLine_ditales_dialog.dart';
import 'package:loc/featuers/time_line/presentation/manager/show_time_line_cubit/show_time_line_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import 'reservations_data_sourece.dart';

class TimeLineViewBody extends StatefulWidget {
  const TimeLineViewBody({super.key, required this.calendarView});
  final CalendarView calendarView;

  @override
  State<TimeLineViewBody> createState() => _TimeLineViewBodyState();
}

class _TimeLineViewBodyState extends State<TimeLineViewBody> {
  String selectedHall = 'all Halls';
  CalendarController controller = CalendarController();
  MeetingDataSource? events;
  List<String> hallNames = ['all Halls'];
  late Query query;
  bool isEnglish = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedHall = S.of(context).all_halls;
    hallNames[0] = selectedHall;
  }

  @override
  void initState() {
    super.initState();
    getHalls();
    query = FirebaseFirestore.instance.collection('locs');
    _fetchTimeLine();
    isArabic();
  }

  void _fetchTimeLine() {
    BlocProvider.of<ShowTimeLineCubit>(context)
        .getTheTimeLine(hallName: selectedHall);
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

        return Stack(
          children: [
            SfCalendar(
              key: ValueKey(events),
              controller: controller,
              minDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
              maxDate: DateTime(DateTime.now().year, DateTime.now().month + 1,
                  DateTime.now().day),
              onTap: (CalendarTapDetails date) {
                if (date.appointments != null &&
                    date.appointments!.isNotEmpty) {
                  showDitalisDialog(
                      data: date,
                      context: context,
                      message:
                          '${date.appointments![0].userName} ${S.of(context).home_made_a_reservation_from} ${DateFormat('hh:mm a').format(date.appointments![0].from)} ${S.of(context).to} ${DateFormat('hh:mm a').format(date.appointments![0].to)} ${S.of(context).forr} ${date.appointments![0].eventName} ${S.of(context).inn} ${date.appointments![0].hallName}',
                      onOkPressed: () => Navigator.pop(context));
                }
              },
              view: widget.calendarView,
              firstDayOfWeek: 6,
              showDatePickerButton: true,
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 60,
                startHour: 6,
                endHour: 23,
                nonWorkingDays: [],
              ),
              dataSource: events,
            ),
            Positioned(
              top: 0,
              right: isEnglish ? 10 : null,
              left: !isEnglish ? 10 : null,
              child: FutureBuilder(
                future: query.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  }
                  return DropdownButton<String>(
                    iconEnabledColor: kPrimaryColor,
                    value: selectedHall,
                    items: hallNames.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(
                          role,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newHallName) {
                      if (newHallName != null &&
                          hallNames.contains(newHallName)) {
                        setState(() {
                          selectedHall = newHallName;
                          _fetchTimeLine();
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void getHalls() async {
    await FirebaseFirestore.instance
        .collection('locs')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        querySnapshot.docs
            .map((DocumentSnapshot document) => document['name'])
            .forEach((element) {
          if (!hallNames.contains(element)) {
            hallNames.add(element);
          }
        });
      });
    });
  }

  void isArabic() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isEnglish = prefs.getString('locale') == 'en' ||
          prefs.getString('locale') == null;
    });
  }
}
