import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/helper/questoin_alert_dialog.dart';
import 'package:loc/core/helper/snack_bar.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';
import 'package:loc/featuers/requests/presentatoin/manager/user_edit_request_cubit/user_editing_request_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/request_detalis_section.dart';
import '../../../../core/helper/delightful_toast.dart';
import '../manager/show_user_requests_cubit/show_user_requests_cubit.dart';
import 'Request_card.dart';
import 'requset_state_section.dart';

class UserRequestItem extends StatefulWidget {
  final UserRequestModel requestModel;

  const UserRequestItem({
    Key? key,
    required this.requestModel,
  }) : super(key: key);

  @override
  State<UserRequestItem> createState() => _UserRequestItemState();
}

class _UserRequestItemState extends State<UserRequestItem> {
  late UserEditingRequestCubit myCubit;
  @override
  void initState() {
    myCubit = BlocProvider.of<UserEditingRequestCubit>(context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserEditingRequestCubit, UserEditingRequestState>(
      listener: (context, editState) {
        if (editState is UserSelectTheDateSuccess) {
          myCubit.selectStartTime(context);
        } else if (editState is UserSelectStartTimeSuccess) {
          myCubit.selectEndTime(
            context,
            widget.requestModel.hallId,
            widget.requestModel.requestId,
            widget.requestModel.userId,
            widget.requestModel.startTime,
            widget.requestModel.endTime,
          );
        } else if (editState is TheStartTimeIsAfterTheEndTime) {
          showAlertDialog(
            context: context,
            message: editState.errMassege,
            onOkPressed: () => Navigator.pop(context),
          );
        } else if (editState is TheStartTImeTheSameAsTheEndTime) {
          showDelightfulToast(
              message: editState.errMassege, context: context, dismiss: false);
        } else if (editState is UserEditingRequestFailer){
          showDelightfulToast(
              message: editState.message, context: context, dismiss: false); 
      } else if (editState is UserUptadingRequestSuccess) {
     BlocProvider.of<ShowUserRequestsCubit>(context).featchRequests();

  final successMessage = editState.successMessage ?? "Operation completed successfully.";

  showAlertDialog(
    context: context,
    message: successMessage,
    onOkPressed: () => Navigator.pop(context),//TODO:There was an error here when i back handle it!
  );
        } else if (editState is ThereWasConflict) {
          showDelightfulToast(
            message: editState.message,
            context: context,
            dismiss: false,
          );
        }
      },
      builder: (context, editState) {
        return GestureDetector(
          onTap: () {
            if (widget.requestModel.replyState == ReplyState.noReplyYet ||
                widget.requestModel.replyState == ReplyState.accepted) {
              questionItemAlert(
                editVisible:
                    widget.requestModel.replyState == ReplyState.noReplyYet,
                context: context,
                onDelete: () async {
                  Navigator.pop(context);
                  await DataBaseMethouds().deleteMyRequest(
                      widget.requestModel.userId,
                      widget.requestModel.requestId,
                      widget.requestModel.hallId);
                  if (mounted) {
                    // bt3ml check 3la el widget de lsa mwgoda wala la bygy m3 el statfulWidget.
                    showSnackBar(context, 'your request deleted successfully');
                  }
                },
                onPressed: () {
                  Navigator.pop(context);
                  myCubit.selectDate(context);
                },
              );
            } else {
              showAlertDialog(
                context: context,
                message:
                    'You can\'t edit this request because Admin has already replied to it',
                onOkPressed: () => Navigator.pop(context),
              );
            }
          },
          child: RequstCard(
            requestModel: widget.requestModel,
            child: editState is UserEditingRequestLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      RequestDetalisSection(requestModel: widget.requestModel),
                      const Spacer(),
                      RequestStateSection(requestModel: widget.requestModel),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
