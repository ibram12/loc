import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/cubit/select_time_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/sent_reservation_cubit/sent_reservation_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/book_loc_view_body.dart';

import '../../../../generated/l10n.dart';

class BookLocView extends StatelessWidget {
  const BookLocView({Key? key,}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SelectTimeCubit()),
        BlocProvider(create: (context)=>SentReservationCubit())
      ] 
      ,child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(S.of(context).add_reservation),
        ),
        body: const BookLocViewBody(),
      ),
    );
  }
}
