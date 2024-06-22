import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/requests/data/models/user_request_model.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';

class RequestDetalisSection extends StatelessWidget {
  const RequestDetalisSection({super.key, required this.requestModel});
  final UserRequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          requestModel.hallName,
          overflow: TextOverflow.fade,
          style: Styles.textStyle18,
        ),
Text(requestModel.service,style: Styles.textStyle18.copyWith(color: Colors.green),),

        const SizedBox(height: 5),
        Text(
          '${S.of(context).date}: ${DateFormat('MMMM dd, yyyy').format(requestModel.startTime.toDate())}',
          style: Styles.textStyle16,
        ),
        const SizedBox(height: 5),
        Text(
          '${S.of(context).start_time}: ${DateFormat('hh:mm a').format(requestModel.startTime.toDate())}',
          style: Styles.textStyle16,
        ),
        const SizedBox(height: 5),
        Text(
          '${S.of(context).end_time}: ${DateFormat('hh:mm a').format(requestModel.endTime.toDate())}',
          style: Styles.textStyle16,
        ),
      ],
    );
  }
}
