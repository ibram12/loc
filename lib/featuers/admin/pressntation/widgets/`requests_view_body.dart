import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/text_styles/Styles.dart';
import '../manager/get_hall_requests_cubit/get_hall_requests_cubit.dart';
import 'request_item.dart';

class RequestsViewBody extends StatefulWidget {
  const RequestsViewBody({
    super.key,
    required this.hallId,
    required this.onNumberOfDocsChanged,
    required this.hallName,
  });

  final String hallId;
  final String hallName;
  final void Function(int) onNumberOfDocsChanged;

  @override
  State<RequestsViewBody> createState() => _RequestsViewBodyState();
}

class _RequestsViewBodyState extends State<RequestsViewBody> {
  List<Map<String, dynamic>> requests = [];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHallRequestsCubit, GetHallRequestsState>(
      builder: (context, state) {
        if (state is GetHallRequestsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetHallRequestsError) {
          return Center(child: Text(state.message));
        } else if (state is GetHallRequestsSuccess) {
          requests = state.requests;
          if (state.requests.isEmpty) {
            return const Center(
                child: Text('No Requests Yet', style: Styles.textStyle18));
          } else {
            return BlocConsumer<AdminReplyCubit, AdminReplyState>(
              listener: (context, state) {
                if (state is AdminReplyAccept) {
                  showSnackBar(context, 'Request Accepted Successfully',
                      color: Colors.green);
                } else if (state is AdminReplyReject) {
                  showSnackBar(context, 'Request Rejected Successfully',
                      color: Colors.red);
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is AdminReplyLoading,
                  child: ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      return RequestItem(
                        hallName: widget.hallName,
                        hallId: widget.hallId,
                        reservationId: requests[index]['id'],
                        requestModel: requests[index]['request'],
                      );
                    },
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
