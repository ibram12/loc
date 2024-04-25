import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/helper/delete_alert_dialog.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/cubit/select_time_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/custom_hall_image.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';

class BookLocViewBody extends StatefulWidget {
  const BookLocViewBody({super.key, required this.image, required this.hallId});
  final String image;
  final String hallId;
  @override
  State<BookLocViewBody> createState() => _BookLocViewBodyState();
}

class _BookLocViewBodyState extends State<BookLocViewBody> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    var selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    return BlocBuilder<SelectTimeCubit, SelectTimeState>(
      builder: (context, state) {
        if (state is SelectDateSuccess) {
          _date = state.date;
        } else if (state is SelectStartTimeSuccess) {
          _startTime = state.startTime;
        } else if (state is SelectEndTimeSuccess) {
          _endTime = state.endTime;
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomHallImage(
                image: widget.image,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () => selectTimeCubit.selectDate(context, _date),
                  child: Text(_date != null
                      ? '${_date!.year}/${_date!.month}/${_date!.day}'
                      : S.of(context).choose_date)),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () =>
                    selectTimeCubit.selectStartTime(context, _startTime),
                child: Text(_startTime != null
                    ? '${S.of(context).start_time}: ${_startTime!.format(context)}'
                    : S.of(context).set_start_time),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    selectTimeCubit.selectEndTime(context, _endTime),
                child: Text(_endTime != null
                    ? '${S.of(context).end_time}: ${_endTime!.format(context)}'
                    : S.of(context).set_end_time),
              ),
              const SizedBox(height: 20),
              if (_startTime != null && _endTime != null && _date != null)
                Column(
                  children: [
                    Text(
                        '${S.of(context).time_range}: ${_startTime!.format(context)} - ${_endTime!.format(context)}'),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<SentReservationCubit, SentReservationState>(
                      builder: (context, state) {
                        if (state is SentReservationSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showAlertDialog(
                                context: context,
                                message: 'your request Sent Successfully');
                          });
                        }
                        return CustomBotton(
                            backgroundColor: kPrimaryColor,
                            text: state is SentReservationLoading
                                ? "loading"
                                : 'Submit',
                            onPressed: () {
                              state is SentReservationSuccess
                                  ? print("done")
                                  : print("not done");
                              BlocProvider.of<SentReservationCubit>(context)
                                  .sentReservation(
                                      startTime: _startTime!,
                                      endTime: _endTime!,
                                      data: _date!,
                                      hallId: widget.hallId);
                            });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
