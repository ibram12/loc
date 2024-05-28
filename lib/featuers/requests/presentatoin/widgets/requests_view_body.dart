import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/requests/presentatoin/manager/show_user_requests_cubit/show_user_requests_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/request_item.dart';

import '../manager/show_user_requests_cubit/show_user_requests_state.dart';
import '../manager/user_edit_request_cubit/user_editing_request_cubit.dart';

class UserRequestBody extends StatefulWidget {
  const UserRequestBody({
    super.key,
  });

  @override
  State<UserRequestBody> createState() => _UserRequestBodyState();
}

class _UserRequestBodyState extends State<UserRequestBody> {
  initState() {
    BlocProvider.of<ShowUserRequestsCubit>(context).featchRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowUserRequestsCubit, ShowUserRequestsState>(
      builder: (context, state) {
        if (state is UserRequestsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserRequestsError) {
          return Center(child: Text(state.message));
        } else if (state is UserRequestsLoaded) {
          if (state.requests.isEmpty) {
            return const Center(child: Text('No Requests Yet',style:Styles.textStyle18));
          } else {
            return ListView.builder(
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) => UserEditingRequestCubit(),
                  child: UserRequestItem(
                    requestModel: state.requests[index],
                  ),
                );
              },
            );
          }
        } else {
          return Center(
            child: Image.asset('assets/images/erorr.png'),
          );
        }
      },
    );
  }
}
