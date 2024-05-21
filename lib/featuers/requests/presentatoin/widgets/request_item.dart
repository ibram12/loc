import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/helper/alert_dialog.dart';
import 'package:loc/core/helper/questoin_alert_dialog.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';
import 'package:loc/featuers/requests/presentatoin/manager/user_edit_request_cubit/user_editing_request_cubit.dart';

import '../../../../core/helper/delightful_toast.dart';

class UserRequestItem extends StatelessWidget {
  const UserRequestItem({super.key, required this.requestModel});
  final UserRequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<UserEditingRequestCubit>(context);
    return BlocConsumer<UserEditingRequestCubit, UserEditingRequestState>(
      listener: (context, state) {
        if (state is UserSelectTheDateSuccess) {
          myCubit.selectStartTime(
            context,
          );
        }
        if (state is UserSelectStartTimeSuccess) {
          myCubit.selectEndTime(
            context,
            requestModel.hallId,
            requestModel.requestId,
            requestModel.userId,
          );
        }
        if (state is TheStartTimeIsAfterTheEndTime) {
          showAlertDialog(
              context: context,
              message: state.errMassege,
              onOkPressed: () => Navigator.pop(context));
        }
        if (state is TheStartTImeTheSameAsTheEndTime) {
          showAlertDialog(
              context: context,
              message: state.errMassege,
              onOkPressed: () => Navigator.pop(context));
        }
        if (state is UserEditingRequestFailer) {
          showAlertDialog(
              context: context,
              message: state.message,
              onOkPressed: () => Navigator.pop(context));
        }
        if (state is UserUptadingRequestSuccess) {
          showAlertDialog(
              context: context,
              message: state.successMessage,
              onOkPressed: () => Navigator.pop(context));
        }
        if (state is ThereWasConflict) {
          showDelightfulToast(
              message: state.message, context: context, dismiss: false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (requestModel.replyState == ReplyState.noReplyYet) {
              questionItemAlert(
                  context: context,
                  onPressed: () {
                    Navigator.pop(context); //to close the dialog.
                    myCubit.selectDate(
                      context,
                    );
                  });
            } else {
              showAlertDialog(
                  context: context,
                  message:
                      'You can\'t edit this request becuse Admin has already replied to it',
                  onOkPressed: () => Navigator.pop(context));
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: Banner(
              message: requestModel.daily == false ? 'Not Daily' : 'Daily',
              location: BannerLocation.topEnd,
              color: requestModel.daily == false ? Colors.red : Colors.green,
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: state is UserSelectEndTimeSuccess ||
                          state is UserEditingRequestLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          children: [
                            Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  requestModel.hallName,
                                  overflow: TextOverflow.fade,
                                  style: Styles.textStyle18,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Date: ${DateFormat('MMMM dd, yyyy').format(requestModel.startTime.toDate())}',
                                  style: Styles.textStyle16,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Start Time: ${DateFormat('hh:mm a').format(requestModel.startTime.toDate())}',
                                  style: Styles.textStyle16,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'End Time: ${DateFormat('hh:mm a').format(requestModel.endTime.toDate())}',
                                  style: Styles.textStyle16,
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (requestModel.replyState.description ==
                                ReplyState.noReplyYet.description)
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 20,
                                child: Image.asset(
                                  'assets/images/9032185_pending_chatting_load_chat_social media_icon.png',
                                  height: 30,
                                ),
                              ),
                            if (requestModel.replyState !=
                                ReplyState.noReplyYet)
                              CircleAvatar(
                                backgroundColor:
                                    requestModel.replyState.description ==
                                            ReplyState.accepted.description
                                        ? Colors.green
                                        : Colors.red,
                                radius: 20,
                                child: Icon(
                                  requestModel.replyState.description ==
                                          ReplyState.accepted.description
                                      ? Icons.check
                                      : Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
