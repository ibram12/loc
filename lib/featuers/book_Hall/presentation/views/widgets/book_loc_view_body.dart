import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/delightful_toast.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/widgets/custom_botton.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/select_time_cubit/select_time_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/views/all_Locs_view.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import 'user_choices.dart';

class BookLocViewBody extends StatefulWidget {
  const BookLocViewBody({
    super.key,
  });
  @override
  State<BookLocViewBody> createState() => _BookLocViewBodyState();
}

class _BookLocViewBodyState extends State<BookLocViewBody> {
  Timestamp? _startTime;
  Timestamp? _endTime;
  DateTime? _date;
  late SelectTimeCubit selectTimeCubit;
  String? _selectedText;

  @override
  void initState() {
    selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectTimeCubit, SelectTimeState>(
      listener: (context, state) {
        if (state is SelectDateSuccess) {
          _date = state.date;
          selectTimeCubit.selectStartTime(context);
        } else if (state is SelectStartTimeSuccess) {
          _startTime = state.startTime;
          selectTimeCubit.selectEndTime(context);
        } else if (state is SelectEndTimeSuccess) {
          _endTime = state.endTime;
        } else if (state is SelectTimeFailer) {
          showDelightfulToast(
              message: state.message, context: context, dismiss: false);
        } else if (state is TheStartTimeAfterTheEndTimeError) {
          showDelightfulToast(
              message: state.message, context: context, dismiss: false);
        } else if (state is TheEndTimeAsSameAsStartTimeError) {
          showDelightfulToast(
              message: state.message, context: context, dismiss: false);
        }
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserChoices(
                  onServiceSelected: (String? selectedService) {
                    setState(() {
                      _selectedText = selectedService;
                    });
                  },
                ),
                if (state is SelectTimeSuccess)
                  Column(
                    children: [
                    
                      CustomBotton(
                          backgroundColor: kPrimaryColor,
                          text: state is Loading ? 'Loading...' : 'Submit',
                          onPressed: () {
                            if (_selectedText != null && _selectedText != '') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AllLocsView(
                                    selectedService: _selectedText!,
                                    startTime: _startTime!,
                                    endTime: _endTime!,
                                  ),
                                ),
                              );
                            } else {
                              showSnackBar(context, 'please, Select Service');
                            }
                          }),
                          const SizedBox(height: 20),
                            Text(
                          '${S.of(context).time_range}: \n on ${DateFormat('yyyy-MM-dd').format(_date!)} at \n${DateFormat('hh:mm a').format(_startTime!.toDate())}, to ${DateFormat('hh:mm a').format(_endTime!.toDate())}\n to make:${_selectedText ?? 'SELECT YOUR SERVICE'} '),
                
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
