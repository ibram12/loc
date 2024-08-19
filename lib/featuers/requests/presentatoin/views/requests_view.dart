import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/requests/presentatoin/manager/user_accept_admin_offer_cubit/user_accept_admin_offer_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/requests_view_body.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../manager/show_user_requests_cubit/show_user_requests_cubit.dart';

class UserRequests extends StatelessWidget {
  const UserRequests({super.key});
  static const String id = "UserRequests";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowUserRequestsCubit(),
        ),
        BlocProvider(
          create: (context) => UserAcceptAdminOfferCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(S.of(context).app_bar_title_your_requests),
        ),
        body: const UserRequestBody(),
      ),
    );
  }
}
