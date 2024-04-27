import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/cubit/select_time_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';
import 'user_choices.dart';

class BookLocViewBody extends StatefulWidget {
  const BookLocViewBody({super.key,});
  @override
  State<BookLocViewBody> createState() => _BookLocViewBodyState();
}

class _BookLocViewBodyState extends State<BookLocViewBody> {
  Timestamp? _startTime;
  Timestamp? _endTime;
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
        return BlocBuilder<GetFilteringDataCubit, GetFilteringDataState>(
          builder: (context, state) {
            if (state is GetFilteringDataSuccess) {
              isLoading = false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showAlertDialog(
                    context: context,
                    message: 'your request Sent Successfully');
              });
            }else if (state is GetFilteringDataLoading) {
              isLoading = true;
            }
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Center(
                child: SingleChildScrollView(
                  child:Column(
                    children: [
                  const SizedBox(height: 50),
                  UserChoices(
                    date: _date,
                  ),
                  const SizedBox(height: 20),
                  if (_startTime != null && _endTime != null && _date != null)
                    Column(
                      children: [
                        Text(
                            '${S.of(context).time_range}: ${_startTime!.toDate().hour}:${_startTime!.toDate().minute} - ${_endTime!.toDate().hour}:${_endTime!.toDate().minute}'),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBotton(
                            backgroundColor: kPrimaryColor,
                            text: 'Submit',
                            onPressed: () {
                              BlocProvider.of<GetFilteringDataCubit>(context)
                                  .sentReservation(
                                    endTime: _endTime!,
                                    startTime: _startTime!,
                                      data: _date!,
                                    );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
