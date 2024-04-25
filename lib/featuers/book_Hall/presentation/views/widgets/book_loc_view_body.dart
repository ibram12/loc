import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/cubit/select_time_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/clebration_animation.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/custom_hall_image.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';
import 'user_choices.dart';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectTimeCubit, SelectTimeState>(
      builder: (context, state) {
        if (state is SelectDateSuccess) {
          _date = state.date;
        } else if (state is SelectStartTimeSuccess) {
          _startTime = state.startTime;
        } else if (state is SelectEndTimeSuccess) {
          _endTime = state.endTime;
        }
        return BlocBuilder<SentReservationCubit, SentReservationState>(
          builder: (context, state) {
            if (state is SentReservationSuccess) {
              isLoading = false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showAlertDialog(
                    context: context,
                    message: 'your request Sent Successfully');
              });
            }else if (state is SentReservationLoading) {
              isLoading = true;
            }
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SingleChildScrollView(
                child: state is SentReservationSuccess?
                const ClebrationAnimation():
                Column(
                  children: [
                    CustomHallImage(
                image: widget.image,
                                  ),
                const SizedBox(height: 50),
                UserChoices(
                  startTime: _startTime,
                  endTime: _endTime,
                  date: _date,
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
                      CustomBotton(
                          backgroundColor: kPrimaryColor,
                          text: 'Submit',
                          onPressed: () {
                            BlocProvider.of<SentReservationCubit>(context)
                                .sentReservation(
                                    startTime: _startTime!,
                                    endTime: _endTime!,
                                    data: _date!,
                                    hallId: widget.hallId);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
