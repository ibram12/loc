import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/add_request/add_request_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/all_locs_view_body.dart';

import '../../../../generated/l10n.dart';
import '../manager/cubits/featch_avilable_halls/featch_avilable_halls_cubit.dart';
import '../manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';

class AllLocsView extends StatelessWidget {
  const AllLocsView(
      {super.key, required this.startTime, required this.endTime,required this.selectedService});
  final Timestamp startTime;
  final Timestamp endTime;
  final String selectedService;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context) => FeatchAvilableHallsCubit()),
        BlocProvider(create: (context) => SentReservationToAdminCubit()),
        BlocProvider(create: (context) => AddRequestToUserCubit()),
      ] ,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Text(S.of(context).book_hall),
        ),
        body: AllLocsViewBody(
          startTime: startTime,
          endTime: endTime,
          selectedService:selectedService
        ),
      ),
    );
  }
}
