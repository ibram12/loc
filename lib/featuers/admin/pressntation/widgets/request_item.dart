import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/admin_alert_dialog.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/question_dialog.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/request_item_body.dart';
import '../../../../core/helper/alert_dialog.dart';
import '../../../../core/helper/delightful_toast.dart';
import '../../../../core/helper/snack_bar.dart';

class RequestItem extends StatefulWidget {
  const RequestItem({
    super.key,
    required this.requestModel,
    required this.reservationId,
    required this.hallId,
    required this.hallName,
  });
  final RequestModel requestModel;
  final String reservationId;
  final String hallId;
  final String hallName;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  late EditRequestCubit myCubit;
  @override
  void initState() {
    // TODO: implement initState
    myCubit = BlocProvider.of<EditRequestCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditRequestCubit, EditRequestState>(
      listener: (context, state) {
        if (state is EditTheDateSuccess) {
          myCubit.selectStartTime(context, widget.requestModel.startTime);
        } else if (state is EditStartTimeSuccess) {
          myCubit.selectEndTime(
              context,
              widget.hallId,
              widget.requestModel.requestId,
              widget.requestModel.id,
              widget.requestModel.endTime,widget.requestModel.startTime,widget.reservationId);
        } else if (state is TheStartTimeIsAfterTheEndTime) {
          showAlertDialog(
            context: context,
            message: state.errMassege,
            onOkPressed: () => Navigator.pop(context),
          );
        } else if (state is TheStartTImeTheSameAsTheEndTime) {
          showDelightfulToast(
              message: state.errMassege, context: context, dismiss: false);
        } else if (state is EditRequestFailer) {
          showDelightfulToast(
              message: state.message, context: context, dismiss: false);
        } else if (state is UserUptadingRequestSuccess) {
          showAlertDialog(
            context: context,
            message: state.successMessage,
            onOkPressed: () => Navigator.pop(context),
          );
        } else if (state is ThereWasConflict) {
          showDelightfulToast(
            message: state.message,
            context: context,
            dismiss: false,
          );
        }
      },
      builder: (context, editstate) {
        return BlocBuilder<AdminChangeDailyStateCubit,
            AdminChangeDailyStateState>(
          builder: (context, state) {
            if (state is AdminChangeDailyStateFalier) {
              showSnackBar(
                  context, 'sorry there was an error, please try later',
                  color: Colors.red);
            }
            return GestureDetector(
              onLongPress: () {
                showQuestionDialog(
                  contextt: context,
                  requestModel: widget.requestModel,
                  reservationId: widget.reservationId,
                  hallId: widget.hallId,
                );
              },
              onTap: () {
                adminAlrtDialog(
                    onEdit: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<EditRequestCubit>(context)
                          .selectDate(context);
                    },
                    hallName: widget.hallName,
                    requestModel: widget.requestModel,
                    context: context,
                    onAccept: () {
                      BlocProvider.of<AdminReplyCubit>(context)
                          .adminReplyAccept(
                              hallId: widget.hallId,
                              reservatoinId: widget.reservationId,
                              userId: widget.requestModel.id,
                              requestId: widget.requestModel.requestId);
                      Navigator.of(context).pop();
                    },
                    onReject: () {
                      BlocProvider.of<AdminReplyCubit>(context)
                          .adminReplyReject(
                        hallId: widget.hallId,
                        reservatoinId: widget.reservationId,
                        userId: widget.requestModel.id,
                        requestId: widget.requestModel.requestId,
                      );
                      Navigator.of(context).pop();
                    });
              },
              child: RequestItemBody(
                  requestModel: widget.requestModel,
                  isLoading: state is AdminChangeDailyStateLoading ||editstate is EditRequestLoading),
            );
          },
        );
      },
    );
  }
}
