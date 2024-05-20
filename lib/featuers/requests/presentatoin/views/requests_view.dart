import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/requests/presentatoin/manager/user_edit_request_cubit/user_editing_request_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/requests_view_body.dart';

import '../../../../core/utils/constants.dart';

class UserRequests extends StatelessWidget {
  const UserRequests({super.key});
  static const String id = "UserRequests";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserEditingRequestCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('your requests'),
        ),
        body: const UserRequestBody(),
      ),
    );
  }
}
