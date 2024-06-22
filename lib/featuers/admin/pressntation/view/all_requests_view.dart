import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/get_all_requests_cubit/get_all_requests_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/all_requests_view_body.dart';

import '../../../../generated/l10n.dart';
import '../manager/admin_reply_cubit/admin_reply_cubit.dart';

class AllRequests extends StatelessWidget {
  const AllRequests({super.key});
  static String id = 'AllRequests';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminReplyCubit(),
        ),
        BlocProvider(
          create: (context) => EditRequestCubit(),
        ),
        BlocProvider(
          create: (context) => AdminChangeDailyStateCubit(),
        ),
        BlocProvider(create: (context) => GetAllRequestsCubit()),
      
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            S.of(context).all_requests,
            style: Styles.textStyle20,
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: const AllRequestsViewBody(),
      ),
    );
  }
}
