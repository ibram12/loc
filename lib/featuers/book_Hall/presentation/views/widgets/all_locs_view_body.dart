import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'halls_list_view.dart';

class AllLocsViewBody extends StatelessWidget {
  const AllLocsViewBody(
      {super.key, required this.startTime, required this.endTime, required this.selectedService});
  final Timestamp startTime;
  final Timestamp endTime;
  final String selectedService;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentReservationToAdminCubit, SentReservationState>(
        builder: (context, state) {
      bool isLoading = state is SentReservationLoading;
      return PopScope(
        canPop: !isLoading,
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Stack(children: [
            HallsListView(
              startTime: startTime,
              endTime: endTime,
              selectedService:selectedService
            ),
          ]),
        ),
      );
    });
  }
}
