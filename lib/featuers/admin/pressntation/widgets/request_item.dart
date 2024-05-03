import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/data/models/request_model.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    super.key, required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 3,
      margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding:const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              requestModel.name,
              overflow: TextOverflow.fade,
            style: Styles.textStyle18,
            ),
          const  SizedBox(height: 5),
            Text(
              'Date: ${requestModel.sendDate}',
              style: Styles.textStyle16,
            ),
        const    SizedBox(height: 5),
            Text(
               'Start Time: ${DateFormat('MMMM dd, yyyy - hh:mm a').format(requestModel.startTime.toDate())}',
              style: Styles.textStyle16,
            ),
        const    SizedBox(height: 5),
            Text(
             'End Time: ${DateFormat('MMMM dd, yyyy - hh:mm a').format(requestModel.endTime.toDate())}',
              style: Styles.textStyle16,
            ),
          ],
        ),
      ),
    );
  }
}