import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';

import '../../../../core/text_styles/Styles.dart';

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
    );
  }
}
