import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/helper/admin_alert_dialog.dart';
import 'package:loc/core/helper/alert_dalog.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_change_daily_state/admin_change_daily_state_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/question_dialog.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';
import 'package:loc/featuers/admin/pressntation/manager/admin_reply_cubit/admin_reply_cubit.dart';
import 'package:loc/featuers/admin/pressntation/manager/edit_request_cubit/edit_request_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/request_item_body.dart';
import '../../../../core/helper/delightful_toast.dart';
import '../../../../core/helper/snack_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../requests/data/models/user_request_model.dart';

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
  late EditRequestCubit editCubit;

  @override
  void initState() {
    super.initState();
    editCubit = EditRequestCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => editCubit,
      child: BlocConsumer<EditRequestCubit, EditRequestState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is EditTheDateSuccess) {
            editCubit.selectStartTime(context, widget.requestModel.startTime);
          } else if (state is EditStartTimeSuccess) {
            editCubit.selectEndTime(
                context,
                widget.hallId,
                widget.requestModel.requestId,
                widget.requestModel.id,
                widget.requestModel.endTime,
                widget.requestModel.startTime,
                widget.reservationId,widget.requestModel.userToken);
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
          } else if (state is EditRequestSuccess) {
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
                    context, S.of(context).something_went_wrong_please_try_later,
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
                  if (widget.requestModel.replyState.description !=
                      ReplyState.unaccepted.description) {
                    adminAlrtDialog(
                        onEdit: () {
                          Navigator.of(context).pop();
                          editCubit.selectDate(context);
                        },
                        hallName: widget.hallName,
                        requestModel: widget.requestModel,
                        context: context,
                        onAccept: () {
                          BlocProvider.of<AdminReplyCubit>(context)
                              .adminReplyAccept(
                                                                context: context,

                                hallName: widget.hallName,
                                  reservatoinId: widget.reservationId,
                                  requestModel: widget.requestModel,);
                          Navigator.of(context).pop();
                        },
                        onReject: () {
                          BlocProvider.of<AdminReplyCubit>(context)
                              .adminReplyReject(
                                context: context,
                            hallName: widget.hallName,
                            reservatoinId: widget.reservationId,
                            requestModel: widget.requestModel,
                        
                          );
                          Navigator.of(context).pop();
                        });
                  } else {
                    setState(() {
                      showDelightfulToast(
                          message: S.of(context).this_request_is_already_Unaccepted,
                          context: context,
                          dismiss: true);
                    });
                  }
                },
                child: RequestItemBody(
                    requestModel: widget.requestModel,
                    isLoading: state is AdminChangeDailyStateLoading ||
                        editstate is EditRequestLoading),
              );
            },
          );
        },
      ),
    );
  }
}
