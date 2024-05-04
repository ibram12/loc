import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/widgets/%60requests_view_body.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key, required this.hallName, required this.hallId, required this.onNumberOfDocsChanged});
  final String hallName;
  final String hallId;
  final void Function(int) onNumberOfDocsChanged;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:  Text(
         hallName,
          style: Styles.textStyle20,
        ),
      ),
      body:  RequestsViewBody(hallId: hallId,onNumberOfDocsChanged: onNumberOfDocsChanged),
    );
  }
}
