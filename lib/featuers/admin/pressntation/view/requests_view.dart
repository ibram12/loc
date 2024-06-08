import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/view/reservation_table_view.dart';
import 'package:loc/featuers/admin/pressntation/widgets/%60requests_view_body.dart';



class RequestsView extends StatelessWidget {
  const RequestsView(
      {super.key,
      required this.hallName,
      required this.hallId,
      required this.onNumberOfDocsChanged});
  final String hallName;
  final String hallId;
  final void Function(int) onNumberOfDocsChanged;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminReplyCubit(),
        ),
        BlocProvider(
          create: (context) => AdminChangeDailyStateCubit(),
        ),

      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            hallName,
            style: Styles.textStyle20,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ReservatoinTableView(
                      docId: hallId,
                    );
                  }));
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        body: RequestsViewBody(
          hallId: hallId,
          onNumberOfDocsChanged: onNumberOfDocsChanged,
          hallName: hallName,
        ),
      ),
    );
  }
}
